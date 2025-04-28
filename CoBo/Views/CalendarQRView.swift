//
//  CalendarQRView.swift
//  Project 1 Apple
//
//  Created by Rieno on 25/03/25.
//
import SwiftUI
import CoreImage.CIFilterBuiltins

struct CalendarQRView: View {
    @Environment(\.dismiss) var dismiss
    let booking: Booking  
    var qrCodeText: String {
        generateQRCodeFromBooking(booking)
    }

    var body: some View {
        VStack {
            HStack {
                Button("Close") {
                    dismiss()
                }
                .padding(.trailing,35)
                Text("Add this booking to iCal")
                    .font(.headline)
                Spacer()
            }

            Text("""
Scan this QR code to effortlessly add the 
event to your iCal and receive timely reminders.
""")
            .multilineTextAlignment(.center)
            .font(.callout)
            .padding()
            if let qrImage = generateQRCode(from: qrCodeText) {
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

            

            Spacer()
        }
        .padding()
    }
}
