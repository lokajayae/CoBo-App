//
//  BookingLogView.swift
//  CoBo
//
//  Created by Evan Lokajaya on 07/04/25.
//

import SwiftUI

struct BookingLogView: View {
    @Environment(\.modelContext) var modelContext
    let screenWidth = UIScreen.main.bounds.width
    
    @State private var selectedDate: Date = Date()
    @State private var navigationPath = NavigationPath()
    
    var bookingController = BookingController()
    
    @State var bookings: [Booking] = []
    
    var body: some View {
        GeometryReader {
            geometry in
            NavigationStack(path: $navigationPath) {
                VStack(spacing: 0){
                    ZStack(alignment: .topLeading) {
                        LinearGradient(
                            gradient: Gradient(colors: [Color.white, Color.lightPurple.opacity(0.3)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: screenWidth > 400 ?  geometry.size.width * 0.55 : geometry.size.width * 0.60)
                        .cornerRadius(30, antialiased: true)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .ignoresSafeArea()
                        VStack(alignment: .leading, spacing: geometry.size.height*0.01) {
                            Text("🧾").font(.largeTitle).fontWeight(.bold)
                            Text("Booking Logs").font(screenWidth > 400 ? .title2 : .title3).fontWeight(.bold)
                            Text("Search for current and future booking records here.").font(.callout)
                        }
                        .safeAreaPadding()
                        .padding(.horizontal, geometry.size.width*0.05)
                        .padding(.top, geometry.size.height*0.01)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    VStack(alignment: .leading, spacing: 24) {
                        VStack(alignment: .leading, spacing: 16){
                            Text("Search by date").font(.callout).fontWeight(.medium)
                            DateManager(selectedDate: $selectedDate)
                        }
                        VStack(alignment: .leading){
                            Text("Booking Logs").font(.callout).fontWeight(.medium)
                            if(bookings.count == 0){
                                VStack {
                                    Spacer()
                                    VStack {
                                        Image("no-booking-found")
                                            .foregroundColor(.red)
                                            .font(.system(size: 40))
                                        Text("No bookings found").font(.system(size: 14, weight: .medium)).foregroundColor(.gray).padding(.top, 4)
                                    }
                                    Spacer()
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)

                            }else{
                                ScrollView {
                                    VStack {
                                        ForEach(bookings) { booking in
                                            BookingLogCardComponent(booking: booking)
                                                .padding(.vertical)
                                                .onTapGesture { CGPoint in
                                                    navigationPath.append(BookingLogDetailContext(booking: booking))
                                                }
                                        }
                                        
                                    }
                                }
                            }
                            
                        }
                        
                    }
                    .safeAreaPadding()
                    .padding(.horizontal, 16)
                    .padding(.top, -54)
                }
                .navigationDestination(for: BookingLogDetailContext.self) { context in
                    BookingLogDetailsView(navigationPath: $navigationPath, booking: context.booking)
                }
            }
            .onAppear() {
                bookingController.setupModelContext(modelContext)
                bookingController.autoCloseBooking()
                bookings = bookingController.getBookingsByDate(selectedDate)
            }
            .onChange(of: selectedDate) { oldValue, newValue in
                bookings = bookingController.getBookingsByDate(newValue)
            }
        }
       
    }
}

#Preview {
    BookingLogView()
}
