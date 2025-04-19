//
//  SkeletonView.swift
//  CoBo
//
//  Created by Rieno on 18/04/25.
//

import SwiftUI

struct SkeletonView<S: Shape>: View {
    var shape: S
    var color: Color
    init(_ shape: S, _ color: Color = .gray.opacity(0.3)){
        self.shape = shape
        self.color = color
    }
    @State private var isAnimating: Bool = false
    var body: some View {
        shape
            .fill(color)
            .overlay{
                GeometryReader{
                    let size = $0.size
                    let skeletonWidth = size.width / 2
                    let blurRadius = max(skeletonWidth / 2, 30)
                    let blurDiameter = blurRadius * 2
                    let minX = -(skeletonWidth + blurDiameter)
                    let maxX = size.width + skeletonWidth + blurDiameter
                    
                    Rectangle()
                        .frame(width: skeletonWidth, height: size.height * 2)
                        .frame(height: size.height)
                        .blur(radius: blurRadius)
                        .rotationEffect(.init(degrees: rotation))
                        .blendMode(.softLight)
                        .offset(x: isAnimating  ? maxX: minX)
                }
            }
            .clipShape(shape)
            .compositingGroup()
            .onAppear {
                guard !isAnimating else { return }
                withAnimation(animation){
                    isAnimating = true
                }
            }
            .onDisappear {
                isAnimating = false
            }
            .transaction{
                if $0.animation != animation {
                    $0.animation = .none
                }
            }
    }
  
    var rotation: Double{
        return 5
    }
    var animation: Animation{
        .easeInOut(duration: 0.5
        ) .repeatForever(autoreverses: false)
    }
}

#Preview {
    @Previewable
    @State var isTapped: Bool = false
    SkeletonView(.circle)
        .frame(width: 100, height:100)
        .onTapGesture {
            withAnimation(.smooth){
                isTapped.toggle()
            }
        }
        .padding(.bottom, isTapped ? 15:0)
}
