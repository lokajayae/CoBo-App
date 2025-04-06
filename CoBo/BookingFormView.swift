//
//  BookingFormView.swift
//  CoBo
//
//  Created by Evan Lokajaya on 26/03/25.
//

import SwiftUI
import SwiftData

struct BookingFormView: View {
    @Binding var navigationPath: NavigationPath
    
    let bookingDate: Date
    let timeslot: Timeslot
    let collabSpace: CollabSpace
    
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
    @State private var selectedItems: [User] = [DataManager.getUsersData()[1]]
    
    @State var showAlert: Bool = false
    @State var emptyFields: [String] = []
    
    @State private var isNavigatingToBookingConfirmation = false
    @State private var bookingToConfirm: Booking?
    
    var users: [User] = DataManager.getUsersData()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Date")
                    Spacer()
                    Text(formattedDate)
                }
                .padding(.vertical)
                Divider()
                HStack {
                    Text("Time")
                    Spacer()
                    Text(timeslot.name)
                }
                .padding(.vertical)
                Divider()
                HStack {
                    Text("Space")
                    Spacer()
                    Text(collabSpace.name)
                }
                .padding(.vertical)
                Divider()
                HStack{
                    Text("Coordinator")
                    Text("*").foregroundStyle(Color.red)
                }
                .padding(.top, 25)
                
                SearchableDropdownComponent(selectedItem: $bookingCoordinator, data: users)
                    .onChange(of: bookingCoordinator) { oldValue, newValue in
                            if let coordinatorName = newValue?.name {
                                meetingName = "\(coordinatorName)'s Meeting"
                            } else {
                                meetingName = ""
                            }
                        }
                
                HStack{
                    Text("Meeting's Name")
                    Text("*").foregroundStyle(Color.red)
                }
                .padding(.top, 25)
                
                TextField("Challenge Group Meeting", text: $meetingName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack{
                    Text("Purpose")
                    Text("*").foregroundStyle(Color.red)
                }
                .padding(.top, 25)
                BookingPurposeDropdownComponent(selectedItem: $bookingPurpose)
                
                Text("Add Participant(s)")
                    .padding(.top, 25)
                Text("By adding participants, you automatically include them as invitees in iCal event, available after booking")
                    .padding(.bottom)
                    .font(.system(size: 13))
                    .foregroundStyle(Color.gray)
                MultipleSelectionDropdownComponent(selectedData: $selectedItems, allData: users)
                    .padding(.bottom)
                Spacer()
                
                Button {
                    book()
                } label: {
                    Text("Book")
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 151/255, green: 117/255, blue: 250/255))
                        )
                }
                .padding(.horizontal, 24)
                .padding(.top, 24)
                
            }
            .padding(.horizontal)
    }
        .safeAreaPadding().padding(16)
        .alert(isPresented: $showAlert) {
            let emptyFields = emptyFields.joined(separator: ", ")
            let message = "Please fill in the following fields: \(emptyFields)"
            return Alert(title: Text("Required Fields"), message: Text(message), dismissButton: .default(Text("OK")))
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
