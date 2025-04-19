//
//  BookingView.swift
//  cobo-personal
//
//  Created by Amanda on 25/03/25.
//
import SwiftUI
struct BookingView : View{
    @State private var selectedDate: Date = Date()
    @State private var navigationPath = NavigationPath()
    @State private var isLoading: Bool = false
    @State var bookingController = BookingController()
    @State private var bookings : [Booking] = []
    var body:some View{
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 0){
                ZStack(alignment: .top) {
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.yellow.opacity(0.2)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 220)
                    .ignoresSafeArea()
                    VStack(alignment: .leading, spacing: 6) {
                        Text("🔖").font(.system(size: 34)).fontWeight(.bold)
                        Text("Book Collab Space").font(.system(size: 21)).fontWeight(.bold)
                        Text("Find and book the Collab Space that fits your needs and availability!").font(.system(size: 13))
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 28)
                }
                VStack(alignment: .leading, spacing: 24){
                    VStack(alignment: .leading, spacing: 16){
                        HStack{
                            Image("no-1").resizable(capInsets: EdgeInsets()).frame(width: 16, height: 16)
                            Text("Select date").font(.system(size: 14)).fontWeight(.medium)
                        }
                        DateManager(selectedDate: $selectedDate)
                    }
                    VStack(alignment: .leading){
                        HStack{
                            Image("no-2").resizable(capInsets: EdgeInsets()).frame(width: 16, height: 16)
                            Text("Select available timeslots").font(.system(size: 14)).fontWeight(.medium)
                        }
                        if isLoading {
                            ScrollView {
                                VStack(spacing: 16) {
                                    ForEach(0..<3, id: \.self) { _ in
                                        BookingViewSkeletonCard()
                                    }
                                }
                                .padding(.vertical)
                            }
                        } else {
                            CollabspaceCardManager(navigationPath: $navigationPath, selectedDate: $selectedDate)
                        }
                        
                    }
                }
                .safeAreaPadding()
                .padding(.horizontal, 16)
                .padding(.top, -54)
                
            }
            .navigationDestination(for: BookingFormContext.self) { context in
                BookingFormView(navigationPath: $navigationPath, bookingDate: context.date, timeslot: context.timeslot, collabSpace: context.collabSpace)
            }
            
        }.onChange(of: selectedDate) { oldValue, newValue in
            isLoading = true
            bookings = []
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                bookings = bookingController.getBookingsByDate(newValue)
                isLoading = false
                
            }
            
        }
    }
}

//        Divider()
//                .offset(y: -18)
//        VStack(alignment: .leading, spacing: 12){
//            Text("Available timeslot").font(.system(size: 13)).fontWeight(.medium)
//            TimeslotManager(navigationPath: $navigationPath, collabSpace: .constant(collabSpace), selectedDate: .constant(selectedDate))
//        }
//        .padding(.horizontal, 16)
//        .padding(.bottom, 24)
//    }
//    .background(
//        RoundedRectangle(cornerRadius: 12)
//            .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//            .background(Color.white)
//            .cornerRadius(12)
//            .shadow(color: Color.gray.opacity(0.2),radius: 4)
//
//    )
//    .frame(width: 329)
//



private struct BookingViewSkeletonCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 12) {
                SkeletonView(RoundedRectangle(cornerRadius: 6))
                    .frame(width: 163, height: 170, alignment: .leading)
                    .clipped()
                    .clipShape(TopLeftRoundedShape())
                    .padding(.leading, -15)
                    .padding(.top, -80)
                VStack(alignment: .leading, spacing: 12) {
                    SkeletonView(RoundedRectangle(cornerRadius: 6))
                        .frame(width: 110, height: 20)
                    HStack(alignment: .top, spacing: 8) {
                        VStack(alignment: .leading, spacing: 6) {
                            SkeletonView(RoundedRectangle(cornerRadius: 6))
                                .frame(width: 50, height: 10)

                            HStack(spacing: 6) {
                                VStack(alignment: .leading) {
                                    HStack {
                                        SkeletonView(RoundedRectangle(cornerRadius: 6))
                                            .frame(width: 22, height: 10)
                                        SkeletonView(RoundedRectangle(cornerRadius: 6))
                                            .frame(width: 22, height: 10)
                                    }

                                    HStack {
                                        SkeletonView(RoundedRectangle(cornerRadius: 6))
                                            .frame(width: 22, height: 10)
                                            .offset(y: -10)

                                        VStack {
                                            SkeletonView(RoundedRectangle(cornerRadius: 6))
                                                .frame(width: 22, height: 10)
                                            SkeletonView(RoundedRectangle(cornerRadius: 6))
                                                .frame(width: 22, height: 10)
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }

                        VStack(alignment: .leading, spacing: 6) {
                            SkeletonView(RoundedRectangle(cornerRadius: 6))
                                .frame(width: 50, height: 10)

                            HStack(spacing: 6) {
                                SkeletonView(RoundedRectangle(cornerRadius: 6))
                                    .frame(width: 22, height: 10)
                                SkeletonView(RoundedRectangle(cornerRadius: 6))
                                    .frame(width: 22, height: 10)
                            }
                        }
                    }
}
            }

            Divider()
                .offset(y: -8)

            VStack(alignment: .leading, spacing: 12) {
                SkeletonView(RoundedRectangle(cornerRadius: 12))
                    .frame(width: 120, height: 15)
                HStack {
                    SkeletonView(RoundedRectangle(cornerRadius: 12))
                        .frame(width: 93, height: 36)
                    SkeletonView(RoundedRectangle(cornerRadius: 12))
                        .frame(width: 93, height: 36)
                    SkeletonView(RoundedRectangle(cornerRadius: 12))
                        .frame(width: 93, height: 36)
                }

                HStack {
                    SkeletonView(RoundedRectangle(cornerRadius: 12))
                        .frame(width: 93, height: 36)
                    SkeletonView(RoundedRectangle(cornerRadius: 12))
                        .frame(width: 93, height: 36)
                    SkeletonView(RoundedRectangle(cornerRadius: 12))
                        .frame(width: 93, height: 36)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 1)
        .redacted(reason: .placeholder)
    }
}

    #Preview {
        BookingView()
    }
