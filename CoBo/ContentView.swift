//
//  ContentView.swift
//  CoBo
//
//  Created by Evan Lokajaya on 25/03/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    enum Page {
            case bookSpace
            case checkIn
            case bookingLog
        }

    @State var selectedTab: Page = .bookSpace
    var body: some View {
        TabView(selection: $selectedTab) {
                    Tab("Book Space", systemImage: "person.3.fill", value: .bookSpace){
                        BookingView()
                    }
                    Tab("Check-In", systemImage: "figure.walk.arrival", value: .checkIn){
                        CheckinView()
                    }
                    Tab("Booking Logs", systemImage: "clock.arrow.circlepath", value: .bookingLog){
                        BookingLogView()
                    }
        }.accentColor(.purple)
    }
}

#Preview {
    ContentView()
}






