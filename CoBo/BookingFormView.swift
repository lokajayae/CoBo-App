//
//  BookingFormView.swift
//  CoBo
//
//  Created by Evan Lokajaya on 26/03/25.
//

import SwiftUI
import SwiftData

struct BookingFormView: View {
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
    @State private var selectedItems: [User] = [DataManager.getUsersData()[1]]
    
    var users: [User] = DataManager.getUsersData()
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Date")
                        Spacer()
                        Text(formattedDate)
                    }
                    .padding()
                    Divider()
                    HStack {
                        Text("Time")
                        Spacer()
                        Text(timeslot.name)
                    }
                    .padding()
                    Divider()
                    HStack {
                        Text("Space")
                        Spacer()
                        Text(collabSpace.name)
                    }
                    .padding()
                    Divider()
                    HStack{
                        Text("Coordinator")
                        Text("*").foregroundStyle(Color.red)
                    }
                    .padding(.horizontal)
                    .padding(.top, 25)
                    
                    SearchableDropdownComponent(selectedItem: $bookingCoordinator, data: users)
                        .padding(.horizontal)
                    
                    HStack{
                        Text("Meeting's Name")
                        Text("*").foregroundStyle(Color.red)
                    }
                    .padding(.horizontal)
                    .padding(.top, 25)
                    
                    TextField("Challenge Group Meeting", text: $meetingName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    HStack{
                        Text("Purpose")
                        Text("*").foregroundStyle(Color.red)
                    }
                    .padding(.horizontal)
                    .padding(.top, 25)
                    TextField("Challenge Group Meeting", text: $meetingName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    Text("Add Participant(s)")
                        .padding([.horizontal, .top])
                    Text("By adding participants, you automatically include them as invitees in iCal event, available after booking")
                        .padding([.horizontal, .bottom])
                        .font(.system(size: 13))
                        .foregroundStyle(Color.gray)
                    MultipleSelectionDropdownComponent(selectedData: $selectedItems, allData: users)
                        .padding([.horizontal, .bottom])
                    Spacer()
                    Button("Book", action: book)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(red: 151/255, green: 117/255, blue: 250/255)) // Purple color similar to image
                        )
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                    
                }
                .padding(.horizontal)
            }
            
                .navigationTitle("Booking Form")
                .navigationBarTitleDisplayMode(.inline)
        }
        .safeAreaPadding().padding(16)
    }
    
    func book() {
        
    }
}

#Preview {
    var bookingDate: Date = .now
    var timeslot = DataManager.getTimeslotsData().first!
    
    var collabSpace = DataManager.getCollabSpacesData().first!
    BookingFormView(bookingDate: bookingDate, timeslot: timeslot, collabSpace: collabSpace)
}
