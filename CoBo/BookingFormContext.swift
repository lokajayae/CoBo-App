//
//  BookingFormContext.swift
//  CoBo
//
//  Created by Evan Lokajaya on 06/04/25.
//

import Foundation

struct BookingFormContext: Hashable {
    let date: Date
    let timeslot: Timeslot
    let collabSpace: CollabSpace
}
