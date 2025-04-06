//
//  BookingConfirmationView.swift
//  CoBo
//
//  Created by Evan Lokajaya on 27/03/25.
//

import SwiftUI

struct BookingConfirmationView: View {
    @Binding var navigationPath: NavigationPath
    var booking: Booking?
    
    var formattedBookingDate: String {
        guard let booking = booking else { return "" }
        
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEEE"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        
        return "\(weekdayFormatter.string(from: booking.date)), \(dateFormatter.string(from: booking.date))"
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image("booking-confirmation-icon")
                    .resizable()
                    .frame(width: 66.0, height: 66.0)
                    .padding(.bottom, 20)
                Text("Review Your Booking")
                    .font(.system(size: 21))
                    .bold()
                    .padding(.bottom, 20)
                Text("Please review your booking before confirming")
                    .font(.system(size: 13))
                    .padding(.bottom, 25)
                HStack {
                    Text("Date")
                    Spacer()
                    Text(formattedBookingDate)
                }
                .padding(.top, 15)
                .padding(.bottom, 15)
                Divider()
                HStack {
                    Text("Time")
                    Spacer()
                    Text(booking?.timeslot.name ?? "")
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                Divider()
                HStack {
                    Text("Space")
                    Spacer()
                    Text(booking?.collabSpace.name ?? "")
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                Divider()
                HStack {
                    Text("Coordinator")
                    Spacer()
                    Text(booking?.coordinator?.name ?? "")
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                Divider()
                HStack {
                    Text("Meeting Name")
                    Spacer()
                    Text(booking?.name ?? "")
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                Divider()
                HStack {
                    Text("Purpose")
                    Spacer()
                    Text(booking?.purpose?.rawValue ?? "")
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                Divider()
                HStack(alignment: .top) {
                    Text("Participants")
                    Spacer()
                    VStack {
                        ForEach(booking?.participants ?? []) { participant in
                            Text(participant.name)
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                
                ZStack {
                    Button(action: {
                        confirmBooking()
                    }) {
                        Text("Confirm")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color("Purple"),
                                        Color("Medium-Purple")
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(24)
                            .padding(.horizontal, 12)
                            .padding(.top, 24)
                    }
                    .padding(.bottom, 40)
                }
            }
        }
        .safeAreaPadding()
        .padding(16)
        .navigationTitle("Booking Confirmation")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: BookingSuccessContext.self) { context in
            BookingSuccessView(navigationPath: $navigationPath, booking: context.booking)
        }
    }
    
    func confirmBooking() {
        guard let unwrappedBooking = booking else { return }
        navigationPath.append(BookingSuccessContext(booking: unwrappedBooking))
    }
}

#Preview {
    let navigationPath = NavigationPath()
    let booking = DataManager.getBookingData().first!
    BookingConfirmationView(navigationPath: .constant(navigationPath), booking: booking)
}
