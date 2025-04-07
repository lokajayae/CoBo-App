import SwiftUI
import UIKit
import CoreImage.CIFilterBuiltins


func generatePlaceholderQRCode() -> String {
    return """
    BEGIN:VCALENDAR
    VERSION:2.0
    PRODID:-//hacksw/handcal//NONSGML v1.0//EN
    BEGIN:VEVENT
    UID:550e8400-e29b-41d4-a716-446655440000
    DTSTART:20250327T051800Z
    DTEND:20250327T052300Z
    SUMMARY:Meeting Name (*)
    DESCRIPTION: Code (*)
    ORGANIZER;CN=Emmanuel Rieno:mailto:emmanuelbobba3@gmail.com
    ATTENDEE;CUTYPE=INDIVIDUAL;ROLE=REQ-PARTICIPANT;PARTSTAT=NEEDS-ACTION;RSVP=TRUE;CN=Evan Lokajaya:mailto:lokajaya41D4@gmail.com

    BEGIN:VALARM
    ACTION:DISPLAY
    DESCRIPTION:Reminder for Meeting
    TRIGGER:-PT15M
    END:VALARM

    BEGIN:VALARM
    ACTION:DISPLAY
    DESCRIPTION:Follow Up for Check-In
    TRIGGER:PT0M
    END:VALARM

    END:VEVENT
    END:VCALENDAR
    """
}

func generateQRCode(from string: String) -> UIImage? {
    print("Generating QR Code for: \(string.prefix(50))...")
    
    let data = string.data(using: .utf8)
    let filter = CIFilter.qrCodeGenerator()
    filter.setValue(data, forKey: "inputMessage")
    filter.setValue("M", forKey: "inputCorrectionLevel")

    if let outputImage = filter.outputImage {
        let transform = CGAffineTransform(scaleX: 10, y: 10) 
        let scaledCIImage = outputImage.transformed(by: transform)
        
        let context = CIContext()
        if let cgImage = context.createCGImage(scaledCIImage, from: scaledCIImage.extent) {
            return UIImage(cgImage: cgImage)
        }
    }
    
    print("Failed to generate QR Code")
    return nil
}
