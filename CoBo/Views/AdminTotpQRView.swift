//
//  AdminTotpQRView.swift
//  CoBo
//
//  Created by Evan Lokajaya on 20/04/25.
//

import SwiftUI

struct AdminTotpQRView: View {
    var image: Image?
    
    var body: some View {
        VStack {
            Text("Scan this QR Code using your preferred authenticator")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            if let qrImage = image{
                qrImage
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(maxWidth: 250, maxHeight: 250)
                    .background(Color.gray.opacity(0.2))
            } else {
                Text("Failed to generate QR code")
                    .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    AdminTotpQRView(image: nil)
}
