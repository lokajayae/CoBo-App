//
//  BookingConfirmationView.swift
//  CoBo
//
//  Created by Evan Lokajaya on 27/03/25.
//

import SwiftUI

struct BookingConfirmationView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var navigationPath: NavigationPath
    
    var bookingController = BookingController()
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
                    .padding(.bottom, 6)
                Text("Please review your booking before confirming")
                    .font(.system(size: 13))
                    .padding(.bottom, 25)
                HStack {
                    Text("Date")
                        .font(.system(size: 14))
                    Spacer()
                    Text(formattedBookingDate).font(.system(size: 13, weight: .medium))
                }
                .padding(.top, 15)
                .padding(.bottom, 15)
                Divider()
                HStack {
                    Text("Time").font(.system(size: 14))
                    Spacer()
                    Text(booking?.timeslot.name ?? "").font(.system(size: 13, weight: .medium))
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                Divider()
                HStack {
                    Text("Space").font(.system(size: 14))
                    Spacer()
                    Text(booking?.collabSpace.name ?? "").font(.system(size: 13, weight: .medium))
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                Divider()
                HStack {
                    Text("Coordinator").font(.system(size: 14))
                    Spacer()
                    Text(booking?.coordinator?.name ?? "").font(.system(size: 13, weight: .medium))
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                Divider()
                HStack {
                    Text("Meeting Name").font(.system(size: 14))
                    Spacer()
                    Text(booking?.name ?? "").font(.system(size: 13, weight: .medium)).frame(maxWidth: .infinity, alignment: .trailing)                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                Divider()
                HStack {
                    Text("Purpose").font(.system(size: 14))
                    Spacer()
                    Text(booking?.purpose?.rawValue ?? "").font(.system(size: 13, weight: .medium))
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
                Divider()
                HStack(alignment: .top) {
                    Text("Participants").font(.system(size: 14))
                    Spacer()
                    VStack(alignment: .trailing){
                        if booking?.participants.count ?? 0 == 0 {
                            Text("No participants inputted").font(.system(size: 13)).foregroundColor(.gray)
                        }else{
                            ForEach(booking?.participants ?? []) { participant in
                                Text(participant.name).font(.system(size: 13, weight: .medium))
                            }
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
                                Color("Purple")
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
        .onAppear() {
            bookingController.setupModelContext(modelContext)
        }
    }
    
    func confirmBooking() {
        guard let unwrappedBooking = booking else { return }
        bookingController.addBooking(booking: unwrappedBooking)
        navigationPath.append(BookingSuccessContext(booking: unwrappedBooking))
    }
}

#Preview {
    let navigationPath = NavigationPath()
    let booking = DataManager.getBookingData().first!
    BookingConfirmationView(navigationPath: .constant(navigationPath), booking: booking)
}
