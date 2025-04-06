//
//  BookingPurpose.swift
//  CoBo
//
//  Created by Evan Lokajaya on 25/03/25.
//

import Foundation


// TODO: Add more booking purpose
enum BookingPurpose: String, Codable {
    case groupDiscussion = "Group Discussion"
    case personalMentoring = "Personal Mentoring"
    case meeting = "Meeting"
    case others = "Others"
    
    static let allValues = [groupDiscussion, personalMentoring, meeting, others]
}
