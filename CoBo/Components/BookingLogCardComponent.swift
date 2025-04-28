//
//  BookingLogCardComponent.swift
//  CoBo
//
//  Created by Evan Lokajaya on 07/04/25.
//

import SwiftUI

struct BookingLogCardComponent: View {
    var booking: Booking
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(booking.name ?? "")
                .font(.callout)
                .bold()
                .padding(.bottom, 8)
            Divider()
            
            HStack {
                Text("Place:")
                    .font(.system(.footnote))
                Text(booking.collabSpace.name)
                    .font(.system(.footnote))
                    .bold()
            }
            
            HStack {
                Text("Coordinator:")
                    .font(.system(.footnote))
                Text(booking.coordinator?.name ?? "")
                    .font(.system(.footnote))
            }
            
            HStack {
                Text("Purpose:")
                    .font(.system(.footnote))
                Text(booking.purpose?.rawValue ?? "")
                    .font(.system(.footnote))
            }
            
            HStack {
                Text("Timeslot:")
                    .font(.system(.footnote))
            }
            
            HStack(alignment: .top) {
                Text(booking.timeslot.name)
                    .font(.system(.footnote, weight: .medium))
                    .padding(.horizontal, 12)
                    .foregroundColor(Color("Dark-Purple"))
                    .frame(height: 36)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("Light-Purple"), lineWidth: 1)
                    )
                
                Spacer()
                
                BookingStatusComponent(status: booking.status)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    let booking = DataManager.getBookingData().first!
    BookingLogCardComponent(booking: booking)
        .padding()
        .background(Color.gray.opacity(0.1))
}
