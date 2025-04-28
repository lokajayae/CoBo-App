//
//  BookingStatusComponent.swift
//  CoBo
//
//  Created by Evan Lokajaya on 07/04/25.
//

import SwiftUI

struct BookingStatusComponent: View {
    @State var status: BookingStatus
    
    var label: String {
        get {
            return switch status {
                case .checkedIn: "Checked-in"
                case .notCheckedIn: "Awaiting for check-in"
                case .closed: "Closed"
                case .canceled: "Canceled"
            }
        }
    }
    
    var color: Color {
        get {
            return switch status {
                case .checkedIn: Color.green.opacity(0.2)
                case .notCheckedIn: Color.yellow.opacity(0.2)
                case .closed: Color.red.opacity(0.2)
                case .canceled: Color.red.opacity(0.2)
            }
        }
    }
    
    var body: some View {
        Text(label)
            .font(.footnote)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(color)
    }
}

#Preview {
    VStack {
        BookingStatusComponent(status: .notCheckedIn)
        BookingStatusComponent(status: .checkedIn)
        BookingStatusComponent(status: .closed)
        BookingStatusComponent(status: .canceled)
    }
}
