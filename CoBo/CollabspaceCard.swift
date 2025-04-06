//
//  CollabspaceCard.swift
//  cobo-personal
//
//  Created by Amanda on 25/03/25.
//
import SwiftUI
struct CollabspaceCard : View{
    @Binding var navigationPath: NavigationPath
    @Binding var collabSpace: CollabSpace
    @Binding var selectedDate: Date
    
    var body: some View{
        VStack(alignment: .leading){
            HStack(spacing: 12){
                Image("\(collabSpace.image)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 163, height: 132.73, alignment: .leading)
                    .offset(y:-6)
                    .clipped()
                    .clipShape(TopLeftRoundedShape())
                VStack(alignment: .leading, spacing: 12){
                    Text(collabSpace.name).font(.system(size: 15)).fontWeight(.bold)
                    HStack(alignment: .top, spacing: 8){
                        VStack(alignment: .leading, spacing:6){
                            Text("Facilities").font(.system(size: 9)).foregroundColor(.gray)
                            if collabSpace.tvAvailable {
                                    HStack(spacing: 6) {
                                        Image(systemName: "tv")
                                            .font(.system(size: 12))
                                        Text("TV")
                                            .font(.system(size: 10))
                                    }
                                }
                            if collabSpace.whiteboardAmount > 1{
                                HStack(alignment: .top, spacing: 6){
                                    Image(systemName:"pencil.line").font(.system(size: 12))
                                    Text("\(collabSpace.whiteboardAmount) Whiteboards ").font(.system(size: 10))
                                }
                            }else if collabSpace.whiteboardAmount > 0{
                                HStack(alignment: .top, spacing: 6){
                                    Image(systemName:"pencil.line").font(.system(size: 12))
                                    Text("\(collabSpace.whiteboardAmount) Whiteboard ").font(.system(size: 10))
                                }
                            }
                            if collabSpace.tableWhiteboardAmount > 1{
                                HStack(alignment: .top, spacing: 6){
                                    Image(systemName:"pencil.line").font(.system(size: 12))
                                    Text("\(collabSpace.tableWhiteboardAmount) Table Whiteboards ").font(.system(size: 10))
                                }
                            }else if collabSpace.tableWhiteboardAmount > 0{
                                HStack(alignment: .top, spacing: 6){
                                    Image(systemName:"pencil.line").font(.system(size: 12))
                                    Text("\(collabSpace.tableWhiteboardAmount) Table Whiteboard").font(.system(size: 10))
                                }
                            }
                        }
                        VStack(alignment: .leading, spacing:6){
                            Text("Capacity").font(.system(size: 9)).foregroundColor(.gray)
                            HStack(spacing: 6){
                                Image(systemName:"person").font(.system(size: 12))
                                Text("\(collabSpace.capacity)").font(.system(size: 10))
                            }
                        }
                    }
                }
            }
            Divider()
                .background(Color.gray.opacity(0.3))
                .frame(width: 329, height: 1)
                    .offset(y: -18)
            VStack(alignment: .leading, spacing: 12){
                Text("Available timeslot").font(.system(size: 13)).fontWeight(.medium)
                TimeslotManager(navigationPath: $navigationPath, collabSpace: .constant(collabSpace), selectedDate: .constant(selectedDate))
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.2),radius: 4)
                
        )
        .frame(width: 329)
        
    }
}

#Preview {
    let navigationPath = NavigationPath()
    CollabspaceCard(navigationPath: .constant(navigationPath), collabSpace: .constant(CollabSpace(
        name: "Collab Space 04",
        capacity: 8, whiteboardAmount: 2, tableWhiteboardAmount: 2, tvAvailable: true, image: "collab-04-img")), selectedDate: .constant(Date()))
}



struct TopLeftRoundedShape: Shape {
    func path(in rect: CGRect) -> Path {
        let radius: CGFloat = 12
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.addQuadCurve(to: CGPoint(x: rect.minX + radius, y: rect.minY), control: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        return path
    }
}
