//
//  BookingStatus.swift
//  CoBo
//
//  Created by Evan Lokajaya on 25/03/25.
//

import Foundation

// TODO: Better case naming for BookingStatus
enum BookingStatus: Codable {
    case checkedIn
    case notCheckedIn
    case closed
}
