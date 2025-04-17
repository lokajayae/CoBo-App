//
//  DataManager.swift
//  CoBo
//
//  Created by Evan Lokajaya on 25/03/25.
//

import Foundation

final class DataManager {
    
    static func getUsersData() -> [User] {
        return [
            User(name: "Evan Lokajaya", email: "lokajaya4141@gmail.com"),
            User(name: "Jesslyn Amanda Mulyawan", email: "jesslynmulyawan2@gmail.com"),
            User(name: "Emmanuel Rieno Bobba", email: "emmanuelbobba33@gmail.com"),
            User(name: "Callista Andreane", email: "menotcallista2@gmail.com"),
            User(name: "Kelvin Alexander Bong", email: "kelvinbong30210@gmail.com"),
            User(name: "Ammar Sufyan", email: "ammarsfyn3@gmail.com"),
            User(name: "Richard Wijaya Harianto", email: "richardharianto041@gmail.com"),
            User(name: "Wiwi Oktriani", email: "wiwioktriani11131@gmail.com"),
            User(name: "Sufi Arifin", email: "zv.1802749@gmail.com"),
            User(name: "Louis Octavianus", email: "luisoktt32@gmail.com"),
            User(name: "Alvin Justine", email: "faajustin0432@gmail.com"),
            User(name: "Brayent Cahyadi", email: "brayentcahyadi324@gmail.com"),
            User(name: "Georgius Kenny Gunawan", email: "ggunawan2523@bsd.idserve.net")
        ]
    }
    
    static func getTimeslotsData() -> [Timeslot] {
        return [
            Timeslot(startHour: 8.0, endHour: 9.167),
            Timeslot(startHour: 9.417, endHour: 10.584),
            Timeslot(startHour: 10.84, endHour: 12.0),
            Timeslot(startHour: 13.0, endHour: 14.167),
            Timeslot(startHour: 14.417, endHour: 15.584),
            Timeslot(startHour: 15.84, endHour: 17.0),
        ]
    }
    
    static func getBookingData() -> [Booking] {
        return [
            Booking(
                name: "Core Challenge Meeting",
                coordinator: DataManager.getUsersData().randomElement(),
                purpose: BookingPurpose.groupDiscussion,
                date: Date(),
                participants: [],
                timeslot: DataManager.getTimeslotsData().randomElement()!,
                collabSpace: DataManager.getCollabSpacesData().randomElement()!,
                status: BookingStatus.notCheckedIn,
                checkInCode:"111111"
            ),
            Booking(
                name: "Personal Mentoring",
                coordinator: DataManager.getUsersData().randomElement(),
                purpose: BookingPurpose.personalMentoring,
                date: Date(),
                participants: [],
                timeslot: DataManager.getTimeslotsData().randomElement()!,
                collabSpace: DataManager.getCollabSpacesData().randomElement()!,
                status: BookingStatus.notCheckedIn,
                checkInCode:"111111"
            )
        ]
    }
    
    // TODO: for booking log
    static func getBookingDataByDate(_ date: Date) -> [Booking] {
        return []
    }
    
    static func getCollabSpacesData() -> [CollabSpace] {
        // TODO: add image
        return [
            CollabSpace(
                name: "Collab - 02",
                capacity: 8,
                whiteboardAmount: 0,
                tableWhiteboardAmount: 1,
                tvAvailable: true,
                image: "collab-02-img"
            ),
            CollabSpace(
                name: "Collab - 03",
                capacity: 8,
                whiteboardAmount: 0,
                tableWhiteboardAmount: 1,
                tvAvailable: true,
                image: "collab-03-img"
            ),
            CollabSpace(
                name: "Collab - 03A",
                capacity: 8,
                whiteboardAmount: 0,
                tableWhiteboardAmount: 1,
                tvAvailable: false,
                image: "collab-03a-img"
            ),
            CollabSpace(
                name: "Collab - 04",
                capacity: 8,
                whiteboardAmount: 0,
                tableWhiteboardAmount: 0,
                tvAvailable: true,
                image: "collab-04-img"
            ),
            CollabSpace(
                name: "Collab - 05",
                capacity: 8,
                whiteboardAmount: 0,
                tableWhiteboardAmount: 0,
                tvAvailable: true,
                image: "collab-05-img"
            ),
            CollabSpace(
                name: "Collab - 07A",
                capacity: 8,
                whiteboardAmount: 1,
                tableWhiteboardAmount: 0,
                tvAvailable: true,
                image: "collab-07-img"
            )
            
        ]
    }
}
