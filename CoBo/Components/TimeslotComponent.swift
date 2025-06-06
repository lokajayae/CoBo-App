//
//  TimeslotView.swift
//  cobo-personal
//
//  Created by Amanda on 25/03/25.
//

import SwiftUI

struct TimeslotComponent: View {
    @Binding var navigationPath: NavigationPath
    @Binding var timeslot: Timeslot
    @Binding var isBooked: Bool
    
    var selectedDate: Date
    @Binding var collabSpace: CollabSpace
    
    var geometrySize: CGFloat
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        NavigationLink(value: BookingFormContext(date: selectedDate, timeslot: timeslot, collabSpace: collabSpace)) {
            if (isBooked) {
                Text("\(timeslot.name)")
                    .font(.system(screenWidth > 400 ? .caption: .caption2))
                    .foregroundColor(Color.gray)
                    .frame(width:geometrySize*0.22, height: 36)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 1)
                    )
            }else {
                Text("\(timeslot.name)")
                    .font(.system(screenWidth > 400 ? .caption: .caption2))
                    .foregroundColor(Color("Dark-Purple"))
                    .frame(width:geometrySize*0.22, height: 36)
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

//
//#Preview {
//    let navigationPath = NavigationPath()
//    let timeslot = DataManager.getTimeslotsData()[0]
//    let collabSpace = DataManager.getCollabSpacesData()[0]
//    let date = Date.now
//    
//    TimeslotComponent(navigationPath: .constant(navigationPath), timeslot: .constant(timeslot), isBooked: .constant(true), selectedDate: date, collabSpace: .constant(collabSpace))
//}
