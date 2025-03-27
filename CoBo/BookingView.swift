//
//  BookingView.swift
//  cobo-personal
//
//  Created by Amanda on 25/03/25.
//
import SwiftUI
struct BookingView : View{
    @State private var selectedDate: Date = Date()
    var body:some View{
        NavigationView {
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
                        CollabspaceCardManager(selectedDate: $selectedDate)
                        
                    }
                }
                .safeAreaPadding()
                .padding(.horizontal, 16)
                .padding(.top, -54)
                
            }
    }
       
    }
}

#Preview {
    BookingView()
}
