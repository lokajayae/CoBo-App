//
//  BookingFormContext.swift
//  CoBo
//
//  Created by Evan Lokajaya on 06/04/25.
//

import Foundation

struct BookingConfirmationContext: Hashable {
    let name: String
    let coordinator: User
    let purpose: BookingPurpose
    let date: Date
    let participants: [User]
    let timeslot: Timeslot
    let collabSpace: CollabSpace
}
