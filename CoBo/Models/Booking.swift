//
//  Booking.swift
//  CoBo
//
//  Created by Evan Lokajaya on 25/03/25.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class Booking: Hashable {
    var name: String?
    var coordinator: User?
    var purpose: BookingPurpose?
    var date: Date
    var participants: [User]
    var createdAt: Date
    var timeslot: Timeslot
    var collabSpace: CollabSpace
    var status: BookingStatus
    var checkInCode: String?
    
    func getCalendarQRCode() -> Image? {
        return nil
    }
    
    init(name: String = "", coordinator: User? = nil, purpose: BookingPurpose? = nil, date: Date, participants: [User] = [], timeslot: Timeslot, collabSpace: CollabSpace, status: BookingStatus = .notCheckedIn, checkInCode: String = "") {
        self.name = name
        self.coordinator = coordinator
        self.purpose = purpose
        self.date = date
        self.participants = participants
        self.createdAt = .now
        self.timeslot = timeslot
        self.collabSpace = collabSpace
        self.status = status
        self.checkInCode = checkInCode
    }
    
}

