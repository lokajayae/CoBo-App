//
//  BookingValidator.swift
//  CoBo
//
//  Created by [Your Name] on [Date].
//

import Foundation

final class bookingValidator {
    
    static func isBookingValid(newBooking: Booking, existingBookings: [Booking]) -> Bool {
        // new booking's time range
        let newStart = newBooking.timeslot.startHour
        let newEnd = newBooking.timeslot.endHour
        
        // check for consecutive bookings using loop
        for booking in existingBookings {
            if booking.coordinator.email == newBooking.coordinator.email {
                let existingStart = booking.timeslot.startHour
                let existingEnd = booking.timeslot.endHour

                // check if the new booking is directly before or after an existing one
                let isConsecutiveBefore = newEnd == existingStart
                let isConsecutiveAfter = newStart == existingEnd
                
                if isConsecutiveBefore || isConsecutiveAfter {
                    return false
                }
            }
        }
        
        return true
    }
}
