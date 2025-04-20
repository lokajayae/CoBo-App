//
//  TotpUtil.swift
//  CoBo
//
//  Created by Evan Lokajaya on 20/04/25.
//

import Foundation
import CommonCrypto

public struct TotpUtil {
    
    // Base32 character set (RFC 4648)
    private static let base32Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
    
    // Base32 decode
    private static func base32Decode(_ input: String) -> [UInt8]? {
        let cleanInput = input.uppercased().replacingOccurrences(of: "=", with: "").replacingOccurrences(of: " ", with: "")
        
        // Calculate the output length
        let outputLength = (cleanInput.count * 5) / 8
        var result = [UInt8](repeating: 0, count: outputLength)
        
        var buffer: Int = 0
        var bitsInBuffer: Int = 0
        var currentByte: Int = 0
        
        for char in cleanInput {
            guard let index = base32Chars.firstIndex(of: char) else {
                return nil // Invalid character
            }
            
            let value = base32Chars.distance(from: base32Chars.startIndex, to: index)
            buffer = (buffer << 5) | value
            bitsInBuffer += 5
            
            while bitsInBuffer >= 8 && currentByte < outputLength {
                result[currentByte] = UInt8((buffer >> (bitsInBuffer - 8)) & 0xFF)
                bitsInBuffer -= 8
                currentByte += 1
            }
        }
        
        return result
    }
    
    public static func generateTotp(timestamp: TimeInterval, secretKey: String, timeStep: Int, digits: Int) -> String {
        // Calculate the time counter value
        let counter = UInt64(floor(timestamp / Double(timeStep)))
        
        // Convert counter to bytes (big-endian)
        var counterBytes = [UInt8](repeating: 0, count: 8)
        
        counterBytes[0] = UInt8((counter >> 56) & 0xFF)
        counterBytes[1] = UInt8((counter >> 48) & 0xFF)
        counterBytes[2] = UInt8((counter >> 40) & 0xFF)
        counterBytes[3] = UInt8((counter >> 32) & 0xFF)
        counterBytes[4] = UInt8((counter >> 24) & 0xFF)
        counterBytes[5] = UInt8((counter >> 16) & 0xFF)
        counterBytes[6] = UInt8((counter >> 8) & 0xFF)
        counterBytes[7] = UInt8(counter & 0xFF)
        
        // Get the decoded secret
        guard let secret = base32Decode(secretKey) else {
            return String(repeating: "0", count: digits)
        }
        
        // Compute HMAC-SHA1
        var macOut = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
        
        CCHmac(
            CCHmacAlgorithm(kCCHmacAlgSHA1),
            secret, secret.count,
            counterBytes, counterBytes.count,
            &macOut
        )
        
        // Dynamic truncation
        let offset = Int(macOut[19] & 0x0F)
        
        // Build the code value
        var codeValue: UInt32 = 0
        codeValue |= UInt32(macOut[offset] & 0x7F) << 24
        codeValue |= UInt32(macOut[offset + 1]) << 16
        codeValue |= UInt32(macOut[offset + 2]) << 8
        codeValue |= UInt32(macOut[offset + 3])
        
        // Calculate modulo directly
        var modulo: UInt32 = 1
        for _ in 0..<digits {
            modulo *= 10
        }
        let code = codeValue % modulo
        
        // Format with leading zeros
        return String(format: "%0\(digits)d", code)
    }
    
    public static func getProvisioningUri(for secretKey: String, username: String) -> String {
        return "otpauth://totp/CoBo:\(username)?secret=\(secretKey)&digits=6&algorithm=SHA1&issuer=CoBo&period=30"
    }
}

