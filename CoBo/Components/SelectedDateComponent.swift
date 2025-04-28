//
//  PickDateView.swift
//  cobo-personal
//
//  Created by Amanda on 25/03/25.
//
import SwiftUI

struct SelectedDateComponent: View {
    @Binding var selectedDate: Date
    let screenWidth = UIScreen.main.bounds.width
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: selectedDate)
    }
    private var dayText: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(selectedDate) {
            return "Today"
        } else {
            let formatter = DateFormatter()
                        formatter.dateFormat = "E"
                        return formatter.string(from: selectedDate)
        }
    }
    var body: some View {
            VStack {
                Text(formattedDate)
                    .font(screenWidth > 400 ? .footnote : .caption)
                    .foregroundColor(.white)
                
                Text(dayText)
                    .font(screenWidth > 400 ? .callout : .footnote)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxHeight: 54)
            .background(
                Color("Purple")
            )
            .cornerRadius(12)
            
        }
    
}

// Example Preview with a selected date
struct SelectedDateView_Previews: PreviewProvider {
    static var previews: some View {
            SelectedDateComponent(selectedDate: .constant(Calendar.current.date(from: DateComponents(year: 2025, month: 4, day: 21))!))
        }
}

