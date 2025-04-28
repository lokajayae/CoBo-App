//
//  BookingSuccessView.swift
//  Project 1 Apple
//
//  Created by Rieno on 25/03/25.
//
import SwiftUI

struct BookingSuccessView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var navigationPath: NavigationPath
    @State private var shadowRadius: CGFloat = 5
    @State private var isPresented = false
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
            VStack(alignment: .leading) {
                HStack {
                    ZStack {
                        circleShape()
                            .fill(Color(red: 33 / 255, green: 216 / 255, blue: 79 / 255))
                            .frame(width: 80, height: 80)
                            .shadow(color: .green, radius: shadowRadius)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                    shadowRadius = 15
                                }
                            }
                        
                        checkmarkShape()
                            .stroke(Color.white, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .frame(width: 65, height: 65)
                    }.padding(.horizontal, 16)
                    
                    Spacer()
                    
                    ZStack {
                        circleBGShape()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(red: 255 / 255, green: 233 / 255, blue: 130 / 255), Color.white]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 165, height: 165)
                            .offset(x: 30, y: -140)
                            .opacity(0.4)
                        
                        circleBGShape2()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color(red: 238 / 255, green: 183 / 255, blue: 255 / 255), Color.white]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .frame(width: 191.28, height: 191.28)
                            .offset(x: 115, y: -60)
                            .opacity(0.4)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                } .padding(.bottom,-30)
                
                VStack(alignment: .leading){
                    VStack(alignment: .leading){
                        Text("Your booking has been placed!")
                            .bold()
                            .font(.title3)
                        
                        Text("Now save this code.")
                            .bold()
                            .padding(.bottom, 10)
                            .font(.title3)
                        
                        Text("This code won't be shown again. ")
                            .font(.callout)
                            .foregroundColor(Color(red: 127 / 255, green: 41 / 255, blue: 154 / 255))
                            .italic()
                            .bold()
                        +
                        Text("Save this 6-digit code for future check-in to verify your attendance.")
                            .font(.callout)
                            .foregroundColor(.primary)
                    }.padding(.horizontal, 16)
                    
                    
                    CodeDisplayComponent(code: booking.checkInCode ?? "XXXXXX")
                    
                    HStack {
                        Button(action: {
                            isPresented = true
                        }) {
                            HStack {
                                Text("Want to add this meeting to iCal?")
                                    .bold()
                                    .foregroundColor(Color("Dark-Purple"))
                                    .font(.body)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color("Dark-Purple"))
                                
                            }
                            .padding(.vertical, 18)
                            .padding(.horizontal, 18)
                            
                        }
                        .background(Color("Light-Purple").opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal, 16)
                        
                    }
                    .padding(.top, 12)
                    .sheet(isPresented: $isPresented) {
                        CalendarQRView(booking: booking)
                            .presentationDetents([.height(400)])
                            .presentationCornerRadius(25)
                    }
                    
                    HStack(alignment: .top) {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.red)
                            .offset(y: 3)
                            .padding(.top,10)
                        Text("Please note that late check-in will cause your booking to be cancelled.")
                            .foregroundStyle(.black)
                            .font(.callout)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top,10)
                    }.padding(.horizontal, 16)
                        .padding(.top, 12)
                    
                    Text("Booking Summary")
                        .bold()
                        .padding(.top, 36)
                        .padding(.bottom,10)
                        .font(.body)
                        .padding(.horizontal, 16)
                    
                    Divider()
                        .background(.gray).padding(.horizontal, 16)
                    
                    Booking_Summary(booking:booking)
                        .padding(.top, 10)
                        .padding(.bottom, 90)
                        .padding(.horizontal, 16)
                }
                
            }
        }
        .overlay(alignment: .bottom) {
            Button(action: {
                navigationPath = NavigationPath()
            }) {
                Text("Back to Home Page")
                    .frame(width: 340, height: 60)
                    .foregroundColor(.white)
                    .font(.body)
                    .background(
                        Color("Purple")
                    )
                    .cornerRadius(24)
                    .padding(.vertical, 8)
                
            }   .frame(width: 400, height: 60).padding(.top, 16)
                .background(.white)
            
        }
        .safeAreaPadding()
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .tabBar)
        
    }
}


#Preview {
    let navigationPath = NavigationPath()
    let booking = DataManager.getBookingData().first!
    BookingSuccessView(navigationPath: .constant(navigationPath), booking: booking)
}
