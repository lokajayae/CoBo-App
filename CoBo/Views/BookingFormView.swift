//
//  BookingFormView.swift
//  CoBo
//
//  Created by Evan Lokajaya on 26/03/25.
//

import SwiftUI
import SwiftData

struct BookingFormView: View {
    @Environment(\.modelContext) var modelContext
    @Binding var navigationPath: NavigationPath
    @State private var showConflictAlert: Bool = false
    @State private var conflictMessage: String = ""
    @FocusState private var isMeetingNameFocused: Bool

    
    let bookingDate: Date
    let timeslot: Timeslot
    let collabSpace: CollabSpace
    
    var userController = UserController()
    
    var formattedDate: String {
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEEE"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        
        return "\(weekdayFormatter.string(from: bookingDate)), \(dateFormatter.string(from: bookingDate))"
    }
    
    @State var meetingName: String = ""
    @State var bookingCoordinator: User?
    @State var bookingPurpose: BookingPurpose? = nil
    @State private var selectedItems: [User] = []
    
    @State var showAlert: Bool = false
    @State var emptyFields: [String] = []
    
    @State private var isNavigatingToBookingConfirmation = false
    @State private var bookingToConfirm: Booking?
    
    @State var users: [User] = []
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Date").font(.system(.callout, weight: .medium))
                    Spacer()
                    Text(formattedDate).font(.system(.callout))
                }
                .padding(.vertical)
                Divider()
                HStack {
                    Text("Time").font(.system(.callout, weight: .medium))
                    Spacer()
                    Text(timeslot.name).font(.system(.callout))
                }
                .padding(.vertical)
                Divider()
                HStack {
                    Text("Space").font(.system(.callout, weight: .medium))
                    Spacer()
                    Text(collabSpace.name).font(.system(.callout))
                }
                .padding(.vertical)
                Divider()
                HStack{
                    Text("Coordinator").font(.system(.callout, weight: .medium))
                    Text("*").foregroundStyle(Color.red)
                }
                .padding(.top, 25)
                
                SearchableDropdownComponent(selectedItem: $bookingCoordinator, data: users)
                    .onChange(of: bookingCoordinator) { oldValue, newValue in
                        if let coordinator = newValue {
                            meetingName = "\(coordinator.name)'s Meeting"
                            
                            let newBooking = Booking(
                                name: meetingName,
                                coordinator: coordinator,
                                purpose: bookingPurpose ?? .others,
                                date: bookingDate,
                                participants: selectedItems,
                                timeslot: timeslot,
                                collabSpace: collabSpace,
                                status: .notCheckedIn,
                                checkInCode: generateCode()
                            )
                            
                            let bookingController = BookingController()
                            bookingController.setupModelContext(modelContext)
                            let existingBookings = bookingController.getAllBooking()
                            
                            let isValid = BookingValidator.isBookingValid(newBooking: newBooking, existingBookings: existingBookings)
                            
                            if !isValid {
                                conflictMessage = "You already have a booking that overlaps or is directly next to this timeslot. Please choose another Collab Space or timeslot."
                                showConflictAlert = true
                                bookingCoordinator = nil
                                meetingName = "" 
                            }
                        } else {
                            meetingName = ""
                        }
                    }
                
                
                HStack{
                    Text("Meeting's Name").font(.system(.callout, weight: .medium))
                    Text("*").foregroundStyle(Color.red)
                }
                .padding(.top, 25)
                
                TextField("Challenge Group Meeting", text: $meetingName)
                    .font(.system(.callout))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isMeetingNameFocused)
                
                HStack{
                    Text("Purpose").font(.system(.callout, weight: .medium))
                    Text("*").foregroundStyle(Color.red)
                }
                .padding(.top, 25)
                BookingPurposeDropdownComponent(selectedItem: $bookingPurpose)
                
                Text("Add Participant(s)").font(.system(.callout, weight: .medium))
                    .padding(.top, 25)
                Text("By adding participants, you automatically include them as invitees in iCal event, available after booking.")
                    .padding(.top, 4)
                    .padding(.bottom,4)
                    .font(.system(.footnote))
                    .foregroundStyle(Color.gray)
                MultipleSelectionDropdownComponent(selectedData: $selectedItems, allData: users)
                    .padding(.bottom)
                Spacer()
                
                Button {
                    book()
                } label: {
                    Text("Book")
                        .font(.system(.body, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(
                            Color("Purple")
                        )
                        .cornerRadius(24)
                        .padding(.horizontal, 12)
                        .padding(.top, 12)
                }
                
                
            }
            .padding(.horizontal)
        }
        .safeAreaPadding()
        .scrollDismissesKeyboard(.immediately)
        .alert(isPresented: $showAlert) {
            let emptyFields = emptyFields.joined(separator: ", ")
            let message = "Please fill in the following fields: \(emptyFields)"
            return Alert(title: Text("Required Fields"), message: Text(message), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showConflictAlert) {
            Alert(
                title: Text("Consecutive Booking Detected"),
                message: Text(conflictMessage),
                dismissButton: .default(Text("OK"))
            )
            
            
        }
        .navigationTitle("Booking Form")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: BookingConfirmationContext.self) { context in
            let newBooking = Booking(
                name: context.name,
                coordinator: context.coordinator,
                purpose: context.purpose,
                date: context.date,
                participants: context.participants,
                timeslot: context.timeslot,
                collabSpace: context.collabSpace,
                status: BookingStatus.notCheckedIn,
                checkInCode: generateCode()
            )
            
            BookingConfirmationView(navigationPath: $navigationPath, booking:newBooking)
        }
        .onAppear() {
            userController.setupModelContext(modelContext)
            users = userController.getAllUser()
        }
        .toolbar(.hidden, for: .tabBar)
    }
    
    func book() {
        emptyFields.removeAll(keepingCapacity: false)
        
        if bookingCoordinator == nil {
            emptyFields.append("Coordinator")
        }
        
        if bookingPurpose == nil {
            emptyFields.append("Purpose")
        }
        
        if meetingName == "" {
            emptyFields.append( "Meeting's Name" )
        }
        
        if (emptyFields.isEmpty) {
            navigationPath.append(BookingConfirmationContext(
                name: meetingName,
                coordinator: bookingCoordinator!,
                purpose: bookingPurpose!,
                date: bookingDate,
                participants: selectedItems,
                timeslot: timeslot,
                collabSpace: collabSpace
            ))
        }
        else {
            showAlert = true
        }
        
    }
    
    func generateCode() -> String {
        let randomNumber = Int.random(in: 100000...999999)
        return String(randomNumber)
    }
}

#Preview {
    let navigationPath = NavigationPath()
    let bookingDate: Date = .now
    let timeslot = DataManager.getTimeslotsData().first!
    
    let collabSpace = DataManager.getCollabSpacesData().first!
    BookingFormView(navigationPath: .constant(navigationPath), bookingDate: bookingDate, timeslot: timeslot, collabSpace: collabSpace)
}
