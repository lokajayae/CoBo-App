//
//  TimeslotView.swift
//  cobo-personal
//
//  Created by Amanda on 25/03/25.
//

import SwiftUI

struct TimeslotComponent: View {
    @Binding var timeslot: Timeslot
    @Binding var isBooked: Bool
    
    var selectedDate: Date
    var collabSpace: CollabSpace
    
    var body: some View {
        NavigationLink(destination: BookingFormView(
            bookingDate: selectedDate,
            timeslot: timeslot,
            collabSpace: collabSpace
        )) {
            // Keep your existing conditional styling here
            if (isBooked) {
                Text("\(timeslot.name)")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color.gray)
                    .frame(width:93, height: 36)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            } else {
                // Your unbooked styling stays the same
                Text("\(timeslot.name)")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(Color("Dark-Purple"))
                    .frame(width:93, height: 36)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("Light-Purple"), lineWidth: 1)
                    )
            }
        }
        .disabled(isBooked)
        
    }
}


#Preview {
    let timeslot = DataManager.getTimeslotsData()[0]
    let collabSpace = DataManager.getCollabSpacesData()[0]
    let date = Date.now
    
    TimeslotComponent(timeslot: .constant(timeslot), isBooked: .constant(true), selectedDate: date, collabSpace: collabSpace)
}
