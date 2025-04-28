//
//  BookingSuccessAutoCI.swift
//  CoBo
//
//  Created by Amanda on 09/04/25.
//
import SwiftUI

struct BookingSuccessAutoCIView : View{
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
    
    var body: some View{
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
                        
                        Text("You can proceed to use the space now.")
                            .bold()
                            .padding(.bottom, 10)
                            .font(.title3)
                        
                    }.padding(.horizontal, 16)

                    Text("Booking Summary")
                        .bold()
                        .padding(.top, 16)
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
    BookingSuccessAutoCIView(navigationPath: .constant(navigationPath), booking: booking)
}
