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
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading) {
                    Image("booking-confirmation-icon")
                        .resizable()
                        .frame(width: 66.0, height: 66.0)
                        .padding(.bottom, 12)
                    Text("Review Your Booking")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 4)
                    Text("Please review your booking before confirming")
                        .font(.system(size: geometry.size.width*0.035))
                        .padding(.bottom, 24)
                    HStack {
                        Text("Date")
                            .font(.system(.callout))
                        Spacer()
                        Text(formattedBookingDate).font(.system(.callout, weight: .medium))
                    }
                    .padding(.top, 15)
                    .padding(.bottom, 15)
                    Divider()
                    HStack {
                        Text("Meeting Time").font(.system(.callout))
                        Spacer()
                        Text(booking?.timeslot.name ?? "").font(.system(.callout, weight: .medium))
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                    Divider()
                    HStack {
                        Text("Space").font(.system(.callout))
                        Spacer()
                        Text(booking?.collabSpace.name ?? "").font(.system(.callout, weight: .medium))
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                    Divider()
                    HStack {
                        Text("Coordinator").font(.system(.callout))
                        Spacer()
                        Text(booking?.coordinator?.name ?? "").font(.system(.callout, weight: .medium))
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                    Divider()
                    HStack {
                        Text("Meeting Name").font(.system(.callout))
                        Spacer()
                        Text(booking?.name ?? "").font(.system(.callout, weight: .medium)).frame(maxWidth: .infinity, alignment: .trailing)                }
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                    Divider()
                    HStack {
                        Text("Purpose").font(.system(.callout))
                        Spacer()
                        Text(booking?.purpose?.rawValue ?? "").font(.system(.callout, weight: .medium))
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                    Divider()
                    HStack(alignment: .top) {
                        Text("Participants").font(.system(.callout))
                        Spacer()
                        VStack(alignment: .trailing){
                            if booking?.participants.count ?? 0 == 0 {
                                Text("No participants inputted").font(.system(.callout)).foregroundColor(.gray)
                            }else{
                                ForEach(booking?.participants ?? []) { participant in
                                    Text(participant.name).font(.system(.callout, weight: .medium))
                                }
                            }
                            
                        }
                    }
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                    
                    ZStack {
                        Button(action: {
                            confirmBooking()
                        }) {
                            Text("Confirm")
                                .font(.body)
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
                if context.isAutoCheckIn {
                    BookingSuccessAutoCIView(navigationPath: $navigationPath, booking: context.booking)
                }
                else {
                    BookingSuccessView(navigationPath: $navigationPath, booking: context.booking)
                }
            }
            .onAppear() {
                bookingController.setupModelContext(modelContext)
            }
        }
        
    }
    
    func confirmBooking() {
        guard let unwrappedBooking = booking else { return }
        
        let isAutoCheckIn = isAutoCheckInBooking(unwrappedBooking)
        
        if isAutoCheckIn {
            unwrappedBooking.status = .checkedIn
        }
        
        bookingController.addBooking(booking: unwrappedBooking)
        navigationPath.append(BookingSuccessContext(booking: unwrappedBooking, isAutoCheckIn: isAutoCheckIn))
    }
    
    func isAutoCheckInBooking(_ booking: Booking) -> Bool {
        let startCheckIn = booking.timeslot.startCheckIn
        let endCheckIn = booking.timeslot.endCheckIn
        let endTimeslot = doubleToTime(booking.timeslot.endHour)
        let date = booking.date
        let calendar = Calendar.current
        let now = Date()
        
        if !calendar.isDate(now, inSameDayAs: date) {
            return false
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        if let startTime = formatter.date(from: startCheckIn),
           let endTime = formatter.date(from: endCheckIn), let endTimeslot = formatter.date(from: endTimeslot) {
            
            let startTimeComponents = calendar.dateComponents([.hour, .minute], from: startTime)
            let endTimeComponents = calendar.dateComponents([.hour, .minute], from: endTime)
            let endTimeslotTimeComponents = calendar.dateComponents([.hour, .minute], from: endTimeslot)
            
            var startDateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            startDateComponents.hour = startTimeComponents.hour
            startDateComponents.minute = startTimeComponents.minute

            var endDateComponents = calendar.dateComponents([.year, .month, .day], from: date)
            endDateComponents.hour = endTimeComponents.hour
            endDateComponents.minute = endTimeComponents.minute
            
            var endTimeslotComponents = calendar.dateComponents([.year, .month, .day], from: date)
            endTimeslotComponents.hour = endTimeslotTimeComponents.hour
            endTimeslotComponents.minute = endTimeslotTimeComponents.minute
            
            if let startDate = calendar.date(from: startDateComponents),
               let endDate = calendar.date(from: endDateComponents),
               let endTimeslotDate = calendar.date(from: endTimeslotComponents) {
                if now >= startDate && now <= endDate {
                    return true
                }
                else if now >= endDate && now <= endTimeslotDate {
                    return true
                }
            }
        }
        
        return false
    }
    
    func doubleToTime(_ number: Double) -> String {
        let hour = Int(number.rounded(.towardZero))
        let minute = Int(number.truncatingRemainder(dividingBy: 1) * 60)
        
        let stringHour = hour < 10 ? "0\(hour)" : String(hour)
        let stringMinute = minute < 10 ? "0\(minute)" : String(minute)
        
        return "\(stringHour):\(stringMinute)"
    }
}

#Preview {
    let navigationPath = NavigationPath()
    let booking = DataManager.getBookingData().first!
    BookingConfirmationView(navigationPath: .constant(navigationPath), booking: booking)
}
