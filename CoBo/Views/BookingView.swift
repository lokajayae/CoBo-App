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
    let screenWidth = UIScreen.main.bounds.width
    var body:some View{
        NavigationStack(path: $navigationPath) {
            GeometryReader{
                geometry in
                VStack(spacing: 0){
                    ZStack(alignment: .top) {
                        LinearGradient(
                            gradient: Gradient(colors: [Color.white, Color.yellow.opacity(0.2)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: screenWidth > 400 ? geometry.size.width * 0.55
                               : geometry.size.width * 0.60)
                        .cornerRadius(30, antialiased: true)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .ignoresSafeArea()
                        VStack(alignment: .leading, spacing: geometry.size.height*0.01) {
                            Text("🔖").font(.system(.largeTitle)).fontWeight(.bold)
                            Text("Book Collab Space").font(screenWidth > 400 ? .title2 : .title3).fontWeight(.bold)
                            Text("Find and book the Collab Space that fits your needs and availability!").font(.callout)
                        }
                        .safeAreaPadding()
                        .padding(.horizontal, geometry.size.width*0.05)
                        .padding(.top, geometry.size.height*0.01)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    VStack(alignment: .leading, spacing: geometry.size.height*0.025){
                        VStack(alignment: .leading, spacing: 16){
                            HStack{
                                Image("no-1").resizable(capInsets: EdgeInsets()).frame(width: geometry.size.width*0.045, height: geometry.size.width*0.045)
                                Text("Select date").font(.system(.callout)).fontWeight(.medium)
                            }
                            DateManager(selectedDate: $selectedDate)
                        }
                        VStack(alignment: .leading){
                            HStack{
                                Image("no-2").resizable(capInsets: EdgeInsets()).frame(width: geometry.size.width*0.045, height: geometry.size.width*0.045)
                                Text("Select available timeslots").font(.system(.callout)).fontWeight(.medium)
                            }
                            CollabspaceCardManager(navigationPath: $navigationPath, selectedDate: $selectedDate, geometrySize: geometry.size.width)
                            
                        }
                    }
                    .safeAreaPadding()
                    .padding(.horizontal, 16)
                    .padding(.top, geometry.size.height*(-0.075))
                    
                }
                .navigationDestination(for: BookingFormContext.self) { context in
                    BookingFormView(navigationPath: $navigationPath, bookingDate: context.date, timeslot: context.timeslot, collabSpace: context.collabSpace)
                }
            }
           
    }
        
    }
}

#Preview {
    BookingView()
}
