//
//  ContentView.swift
//  Project 1 Apple
//
//  Created by Rieno on 25/03/25.
//

import SwiftUI


struct BookingSuccessView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var navigationPath: NavigationPath
    
    @State private var shadowRadius: CGFloat = 5
    @State var isPresented = false
    
    @State var booking: Booking
    
    var formattedBookingDate: String {
        let weekdayFormatter = DateFormatter()
        weekdayFormatter.dateFormat = "EEEE"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        
        return "\(weekdayFormatter.string(from: booking.date)), \(dateFormatter.string(from: booking.date))"
    }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading){
                ZStack{
                    circleBGShape()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.white]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                        .frame(width: 200, height: 200)
                        .opacity(0.3)
                        .offset(x: 210, y: -50)
                        .ignoresSafeArea()
                    
                    circleBGShape2()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [Color.purple, Color.white]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing))
                        .frame(width: 200, height: 200)
                        .opacity(0.2)
                        .offset(x: 280, y: 50)
                        .ignoresSafeArea()
                    circleShape()
                        .fill(Color.green)
                        .frame(width: 80, height: 80)
                        .offset(x: -55, y: 25)
                        .shadow(color: .green, radius: shadowRadius)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                shadowRadius = 15 // Expanding the shadow
                            }}
                    
                    checkmarkShape()
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                        .frame(width: 65, height: 65)
                    .offset(x: -55, y: 25)}
                
                Text("Your booking has been placed!")
                    .padding(.top, -20)
                    .bold(true)
                    .font(.system(size: 17, design: .default))
                Text("Now save this code")
                    .bold(true)
                    .padding(.bottom,10)
                    .font(.system(size: 17, design: .default))
                VStack(alignment: .leading){
                    HStack{
                        Text("This code won't be shown again.")
                            .font(.system(size: 13, design: .default))
                            .foregroundColor(Color(red: 0.5, green: 0.1, blue: 1))
                            .italic(true)
                            .bold(true)
                        Text("Save this 6-digit")
                            .font(.system(size: 13))
                            .padding(.leading,-5)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Text("code for future check-in to verify your attendance.")
                        .font(.system(size: 13))
                }
                CodeDisplayComponent(code: booking.checkInCode ?? "XXXXXX")
                HStack{
                    Button(action: {
                        isPresented = true
                    }) {
                        HStack {
                            Text("Want to add this to iCal?")
                                .bold()
                                .foregroundColor(Color(red: 0.4, green: 0.1, blue: 0.5))
                                .frame(width: 300, height: 50, alignment: .leading)
                                .font(.system(size: 13, design: .default))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                        .padding(.horizontal)
                    }
                    .background(Color(red: 1, green: 0.8, blue: 1))
                    .frame(width: 370, height: 50)
                    .cornerRadius(10)
                    .opacity(0.6)
                }
                .sheet(isPresented: $isPresented) {
                    CalendarQRView()
                        .presentationDetents([.height(400)]) // Set height
                        .presentationCornerRadius(25) // Customize corner radius
                }
                
                
                Text("Check-In Time")
                    .padding(.bottom,10)
                    .padding(.top,10)
                    .bold(true)
                    .font(.system(size: 15))
                HStack{
                    Text("Available on \(formattedBookingDate) (\(booking.timeslot.startCheckIn) - \(booking.timeslot.endCheckIn))")
                        .italic()
                        .bold()
                        .font(.system(size: 15))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                HStack{
                    Image(systemName:"info.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.red, .red)
                        .padding(.bottom,25)
                    Text("Please note that late check-in will cause your booking to be cancelled")
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 15)
                        .font(.system(size: 13))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Text("Booking Summary")
                    .bold(true)
                    .padding(.bottom,15)
                    .font(.system(size: 15))
                HStack{
                    Text("Date")
                        .font(.system(size: 14))
                    Spacer()
                    Text("Date Placeholder")
                        .italic()
                        .font(.system(size: 14))
                        .padding(.trailing)
                }
                .padding(.bottom,50)
                Button(action: {
                    navigationPath = NavigationPath()
                })
                {Text("Back to Home Page")
                        .frame(width: 370, height: 60)
                        .foregroundColor(.white)
                        .font(.system(size: 18, design: .default))
                        .background(
                            ZStack {
                                RadialGradient(gradient: Gradient(colors: [(Color(red: 0.5, green: 0.1, blue: 1)), Color.clear]),
                                               center: .topLeading, startRadius: 20, endRadius: 200)
                                RadialGradient(gradient: Gradient(colors: [(Color(red: 0.5, green: 0.1, blue: 1)), Color.clear]),
                                               center: .topTrailing, startRadius: 20, endRadius: 200)
                                RadialGradient(gradient: Gradient(colors: [(Color(red: 0.5, green: 0.1, blue: 1)), Color.clear]),
                                               center: .center, startRadius: 20, endRadius: 200)
                            }
                        )
                        .cornerRadius(24)
                }
            }
            .safeAreaPadding()
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    let navigationPath = NavigationPath()
    let booking = DataManager.getBookingData().first!
    BookingSuccessView(navigationPath: .constant(navigationPath), booking: booking)
}
