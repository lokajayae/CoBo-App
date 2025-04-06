import SwiftUI
import CoreImage.CIFilterBuiltins

struct CalendarQRView: View {
    @Environment(\.dismiss) var dismiss
    
    var qrCodeText: String {
        generatePlaceholderQRCode()
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Close") {
                    dismiss()
                }
                .padding()

                Text("Add this booking to iCal")
                    .font(.headline)
                Spacer()
            }

            Text("""
Scan this QR code to effortlessly add the 
event to your iCal and receive timely reminders.
""")
            .multilineTextAlignment(.center)
            .font(.system(size: 13))
            .padding()

            if let qrImage = generateQRCode(from: qrCodeText) {
                Image(uiImage: qrImage)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
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

#Preview {
    CalendarQRView()
}
