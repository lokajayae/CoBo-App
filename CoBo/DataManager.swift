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
            User(name: "Evan Lokajaya", email: "lokajaya414@gmail.com"),
            User(name: "Jesslyn Amanda Mulyawan", email: "jesslynmulyawan@gmail.com"),
            User(name: "Emmanuel Rieno Bobba", email: "emmanuelbobba3@gmail.com"),
            User(name: "Callista Andreane", email: "menotcallista@gmail.com"),
            User(name: "Kelvin Alexander Bong", email: "kelvinbong3010@gmail.com"),
            User(name: "Ammar Sufyan", email: "ammarsfyn@gmail.com"),
            User(name: "Richard Wijaya Harianto", email: "richardharianto04@gmail.com"),
            User(name: "Wiwi Oktriani", email: "wiwioktriani1111@gmail.com"),
            User(name: "Sufi Arifin", email: "zv.180279@gmail.com"),
            User(name: "Louis Octavianus", email: "luisoktt@gmail.com"),
            User(name: "Alvin Justine", email: "faajustin04@gmail.com"),
            User(name: "Brayent Cahyadi", email: "brayentcahyadi@gmail.com"),
            User(name: "Georgius Kenny Gunawan", email: "ggunawan25@bsd.idserve.net")
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
                name: "Lokajaya's Meeting",
                coordinator: DataManager.getUsersData()[0],
                purpose: BookingPurpose.groupDiscussion,
                date: Date(),
                participants: [],
                timeslot: DataManager.getTimeslotsData()[5],
                collabSpace: DataManager.getCollabSpacesData()[0],
                status: BookingStatus.notCheckedIn,
                checkInCode:"908724"
            ),
            Booking(
                name: "Lokajaya's Meeting",
                coordinator: DataManager.getUsersData()[0],
                purpose: BookingPurpose.groupDiscussion,
                date: Date(),
                participants: [],
                timeslot: DataManager.getTimeslotsData()[4],
                collabSpace: DataManager.getCollabSpacesData()[1],
                status: BookingStatus.notCheckedIn,
                checkInCode:"908462"
            )
        ]
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
                image: "collab-03-img"
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
                image: "collab-03-img"
            ),
            CollabSpace(
                name: "Collab - 07A",
                capacity: 8,
                whiteboardAmount: 1,
                tableWhiteboardAmount: 0,
                tvAvailable: false,
                image: "collab-07-img"
            )
            
        ]
    }
}
