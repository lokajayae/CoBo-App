//
//  SplashscreenView.swift
//  CoBo
//
//  Created by Amanda on 27/03/25.
//

import SwiftUI

struct SplashscreenView: View {
    @State private var isActive = false
    @State private var opacity = 0.0
    @State private var scale: CGFloat = 0.8

    var body: some View {
        if isActive {
            IntroductionView()
                .transition(.opacity.animation(.easeIn(duration: 0.5)))
        } else {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                Image("splashscreen-key")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .opacity(opacity)
                    .scaleEffect(scale)
                    .onAppear {
                        withAnimation(.easeIn(duration: 1)) {
                            opacity = 1.0
                        }
                      

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isActive = true
                        }
                    }
            }
        }
    }
}

#Preview {
    SplashscreenView()
}
