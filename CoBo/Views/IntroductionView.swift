//
//  IntroductionView.swift
//  cobo-personal
//
//  Created by Amanda on 25/03/25.
//
import SwiftUI

struct IntroductionView:View{
    @State var navigateToBooking : Bool = false
    let screenWidth = UIScreen.main.bounds.width

    var body: some View{
        NavigationStack {
            GeometryReader{
                geometry in
                ZStack{
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color("Light-Yellow").opacity(0.4),
                                Color.white.opacity(0.3)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 100)
                        .edgesIgnoringSafeArea(.top)
                        Spacer()
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color("Light-Purple").opacity(0.75),
                                Color.white.opacity(1.0)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 100))
                        .offset(x:-180, y: -600)
                        .blur(radius: 50)
                    }
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color("Light-Yellow").opacity(0.5),
                            Color.white.opacity(1.0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                    .offset(x:180, y: -100)
                    .blur(radius: 50)
                    
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color("Light-Purple").opacity(0.75),
                            Color.white.opacity(1.0)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                    .offset(x:-220, y: 50)
                    .blur(radius: 50)
                    
                    VStack{
                        Image("introduction-bookcard").resizable()
                            .scaledToFit()
                            .frame(maxWidth: 250, maxHeight: 150)
                            .padding(.leading, 80)
                        
                        HStack{
                            Image("introduction-collabimg")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 220, maxHeight: 220)
                            
                            Image("introduction-timeslots")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 150, maxHeight: 150)
                        }
                        
                        VStack(spacing: 8) {
                            Text("Hello pal! 👋🏻 Welcome to")
                                .font(screenWidth > 400 ? .callout : .footnote)
                            Text("CoBo — Collab Space Booking")
                                .font(.system(.title2, weight: .bold))
                            
                            Text("CoBo lets you easily reserve Collab Spaces at Apple Developer Academy, so you can focus on creating and collaborating with ease!")
                                .font(screenWidth > 400 ? .callout : .footnote)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, geometry.size.width*0.01)
                        }
                        .padding(.top, geometry.size.height * 0.05)
                        Button(action: {
                                        navigateToBooking = true
                                    }) {
                                        Text("Let's get started")
                                            .font(.system(.body))
                                            .foregroundColor(.white)
                                            .padding(.vertical,16)
                                            .frame(maxWidth: .infinity)
                                            .background(
                                                Color("Purple")
                                            )
                                            .cornerRadius(24)
                                            .padding(.horizontal, 12)
                                            .padding(.top, geometry.size.width*0.05)
                                    }
                                    .fullScreenCover(isPresented: $navigateToBooking) {
                                        ContentView()
                                    }
                        
                    
                    }.safeAreaPadding().padding(16)
                    
                }
            }
        }
    }
}

#Preview {
    IntroductionView()
}
