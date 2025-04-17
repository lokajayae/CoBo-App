//
//  CoBoApp.swift
//  CoBo
//
//  Created by Evan Lokajaya on 25/03/25.
//

import SwiftUI
import SwiftData

@main
struct CoBoApp: App {
    var body: some Scene {
        WindowGroup {
            SplashscreenView()
                .preferredColorScheme(.light)
        }
        .modelContainer(for: [Booking.self, CollabSpace.self, Timeslot.self, User.self]) { result in
            do {
                let container = try result.get()
                populateAllData(container: container)
//                // Populate User data
//                try populateData(container: container, fetchDataFunction: DataManager.getUsersData)
//               
//                // Populate CollabSpace data
//                try populateData(container: container,fetchDataFunction: DataManager.getCollabSpacesData)
//                
//                // Populate Timeslot data
//                try populateData(container: container, fetchDataFunction: DataManager.getTimeslotsData)
//                
//                try populateData(container: container, fetchDataFunction: DataManager.getBookingData)
            } catch {
                print("Failed to pre-seed database.")
            }
        }
    }
    
    private func populateData<T: PersistentModel>(
    container: ModelContainer,
    fetchDataFunction: () -> [T]) throws {
        let descriptor = FetchDescriptor<T>()
        let existingCount = try container.mainContext.fetchCount(descriptor)
        
        if existingCount == 0 {
            print("Add data for \(T.self)")
            print("Add \(fetchDataFunction().count) data to \(T.self)")
            for item in fetchDataFunction() {
                container.mainContext.insert(item)
            }
            print("There is \(try container.mainContext.fetchCount(descriptor)) data for \(T.self)")
        }
        
        try container.mainContext.save()
    }
    
    private func populateAllData(container: ModelContainer) {
        let context = container.mainContext
        
        do {
            // Check if we've already populated data
            let userDescriptor = FetchDescriptor<User>()
            let userCount = try context.fetchCount(userDescriptor)
            
            // Only populate if we have no users
            if userCount == 0 {
                print("Populating initial seed data...")
                
                // Step 1: Add Users
                let users = DataManager.getUsersData()
                for user in users {
                    context.insert(user)
                }
                print("Added \(users.count) users")
                
                // Step 2: Add CollabSpaces
                let spaces = DataManager.getCollabSpacesData()
                for space in spaces {
                    context.insert(space)
                }
                print("Added \(spaces.count) collaboration spaces")
                
                // Step 3: Add Timeslots
                let timeslots = DataManager.getTimeslotsData()
                for timeslot in timeslots {
                    context.insert(timeslot)
                }
                print("Added \(timeslots.count) timeslots")
                
                // Save the basic entities first
                try context.save()
                
                // Step 4: Add Bookings using references to existing entities
                // Fetch the saved entities to use as references
                let savedUsers = try context.fetch(userDescriptor)
                
                let timeslotDescriptor = FetchDescriptor<Timeslot>()
                let savedTimeslots = try context.fetch(timeslotDescriptor)
                // TODO: harus urutin time slot
                let spaceDescriptor = FetchDescriptor<CollabSpace>()
                let savedSpaces = try context.fetch(spaceDescriptor)
                
                // Create bookings using references to the saved entities
                let booking1 = Booking(
                    name: "Core Challenge Discussion",
                    coordinator: savedUsers.randomElement(),
                    purpose: BookingPurpose.groupDiscussion,
                    date: Date(),
                    participants: [],
                    timeslot: savedTimeslots.randomElement()!,
                    collabSpace: savedSpaces.randomElement()!,
                    status: BookingStatus.notCheckedIn,
                    checkInCode: "111111"
                )
                
                let booking2 = Booking(
                    name: "Personal Mentoring",
                    coordinator: savedUsers.randomElement(),
                    purpose: BookingPurpose.personalMentoring,
                    date: Date(),
                    participants: [],
                    timeslot: savedTimeslots.randomElement()!,
                    collabSpace: savedSpaces.randomElement()!,
                    status: BookingStatus.notCheckedIn,
                    checkInCode: "222222"
                )
                
                context.insert(booking1)
                context.insert(booking2)
                print("Added 2 bookings")
                
                // Save everything
                try context.save()
                print("All data populated successfully")
            } else {
                print("Data already exists. Skipping population.")
            }
        } catch {
            print("Error populating data: \(error)")
        }
    }
}
