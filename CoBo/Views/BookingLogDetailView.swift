//
//  BookingLogDetailsView.swift
//  CoBo
//
//  Created by Rieno on 09/04/25.
//

import SwiftUI
import Foundation

struct BookingLogDetailsView: View {
    @Binding var navigationPath: NavigationPath
    @Bindable var booking: Booking
    @Environment(\.dismiss) var dismiss
    @State private var users: [User] = []
    @State private var showCancelSheet = false
    @State private var cancelCodeInput = ""
    @State private var cancelErrorMessage: String? = nil
    @State private var showCancelButton = false
    @State private var showSuccessAlert = false

    var userController = UserController()
    var bookingController = BookingController()

    @Environment(\.modelContext) private var modelContext

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ZStack(alignment: .topLeading) {
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.pink.opacity(0.1)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 140)
                    .cornerRadius(30, antialiased: true)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .ignoresSafeArea()
                    
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Spacer()
                        Text("🔎").font(.largeTitle)
                        Text("Booking Details")
                            .font(.title2).bold()
                        Spacer()
                    }                .padding(.horizontal, 32)
                    
                }.alert("Booking Canceled", isPresented: $showSuccessAlert, actions: {}) {
                    Text("Your booking has been successfully canceled.")
                }
                .padding(.bottom, 10)
                Group {
                    InfoRow(title: "Name", value: booking.name ?? "N/A")
                    Divider()
                    
                    InfoRow(title: "Date", value: formattedDate(booking.date))
                    Divider()
                    
                    InfoRow(title: "Timeslot", value: booking.timeslot.name)
                    Divider()
                    
                    InfoRow(title: "Collab Space", value: booking.collabSpace.name)
                    Divider()
                    
                    InfoRow(title: "Purpose", value: booking.purpose?.rawValue ?? "N/A")
                    Divider()
                    
                    InfoRow(title: "Status", value: booking.getStatus())
                    Divider()
                    
                    InfoRow(title: "Created At", value: formattedDateTime(booking.createdAt))
                    Divider()
                    
                    InfoRow(title: "Coordinator", value: booking.coordinator?.name ?? "N/A")
                    Divider()
                    
                    HStack(alignment: .top) {
                        Text("Participants")
                            .bold()
                            .font(.callout)
                        Spacer()
                        VStack(alignment: .trailing, spacing: 4) {
                            if booking.participants.isEmpty {
                                Text("No participants inputted")
                                    .font(.callout)
                                    .multilineTextAlignment(.trailing)
                            } else {
                                ForEach(booking.participants, id: \.id) { participant in
                                    Text(participant.name)
                                        .font(.callout)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                        }
                    }}
         .padding(.horizontal, 32)
                
                
                Spacer()
            }
            
        }
        .toolbar(.hidden, for: .tabBar)
        .navigationTitle("Booking Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            userController.setupModelContext(modelContext)
            bookingController.setupModelContext(modelContext)
            users = userController.getAllUser()
            showCancelButton = booking.status == .notCheckedIn
            
        
        }
        .sheet(isPresented: $showCancelSheet) {
            CancelBookingSheet(
                codeInput: $cancelCodeInput,
                errorMessage: $cancelErrorMessage,
                onConfirm: validateCancelCode
            )
        }

        if showCancelButton {
            Button(action: {
                showCancelSheet = true
            }) {
                Text("Cancel Booking")
                    .font(.system(.body, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(24)
                    .padding(.horizontal, 12)
                    .padding(.top, 12)
            }.padding(.horizontal, 32)
                .padding(.bottom, 32)
        }

    }
    

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }

    func formattedDateTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }

    func validateCancelCode() {
        guard cancelCodeInput == booking.checkInCode else {
            cancelErrorMessage = "Invalid check-in code. Please try again."
            return
        }

        let success = bookingController.cancelBooking(booking)

            if success {
                cancelErrorMessage = nil
                showCancelSheet = false
                showCancelButton = false
                booking.status = .canceled

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showSuccessAlert = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showSuccessAlert = false
                        dismiss()
                    }
                }
    
        } else {
            cancelErrorMessage = "Failed to cancel booking. Please try again."
        }
    }

}

// MARK: - InfoRow
struct InfoRow: View {
    var title: String
    var value: String

    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .bold()
                .font(.callout)
            Spacer()
            Text(value)
                .font(.callout)
                .multilineTextAlignment(.trailing)
                .lineLimit(nil)
                
                .fixedSize(horizontal: false, vertical: true)

        }
    }
}

// MARK: - CancelBookingSheet
struct CancelBookingSheet: View {
    @Binding var codeInput: String
    @Binding var errorMessage: String?
    var onConfirm: () -> Void

    @FocusState private var focusedField: Int?

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("Enter the 6-Digit\nCheck-In Code")
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)

//                HStack(spacing: 12) {
//                    ForEach(0..<6, id: \.self) { index in
//                        CodeBox(index: index, code: $codeInput)
//                            .focused($focusedField, equals: index)
//                            .onChange(of: codeInput) { _ in
//                                focusedField = codeInput.count < 6 ? codeInput.count : nil
//                            }
//                    }
//                }
//                OTPFieldComponent()

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }

                Button(action: onConfirm) {
                    Text("Confirm Cancel")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(24)
                        .padding(.horizontal, 12)
                        .padding(.top, 12)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Cancel Booking")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { focusedField = 0 }
        }
    }
}



#Preview {
    let navigationPath = NavigationPath()
    if let booking = DataManager.getBookingData().first {
        return BookingLogDetailsView(navigationPath: .constant(navigationPath), booking: booking)
    } else {
        return AnyView(Text("No booking data available."))
    }
}
