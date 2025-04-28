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
    var geometrySize: CGFloat
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View{
        VStack(alignment: .leading){
            HStack(spacing: 16){
                Image("\(collabSpace.image)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometrySize*0.4, alignment: .leading)
//                    .offset(y:-6)
                    .clipped()
                    .clipShape(TopLeftRoundedShape())
                VStack(alignment: .leading, spacing: 6){
                    Text(collabSpace.name).font(.callout).fontWeight(.bold)
                    HStack(alignment: .top, spacing: 6){
                        VStack(alignment: .leading, spacing:8){
                            Text("Facilities").font(screenWidth > 400 ? .caption : .system(size: 9)).foregroundColor(Color(.systemGray))
                            if collabSpace.tvAvailable {
                                    HStack(spacing: 6) {
                                        Image(systemName: "tv")
                                            .font(screenWidth > 400 ?.footnote : .system(size: 11))
                                        Text("TV")
                                            .font(screenWidth > 400 ? .caption : .system(size: 9))
                                    }
                                }
                            if collabSpace.whiteboardAmount > 1{
                                HStack(alignment: .top, spacing: 6){
                                    Image(systemName:"pencil.line").font(screenWidth > 400 ?.footnote : .system(size: 11))
                                    Text("\(collabSpace.whiteboardAmount) Whiteboards").font(screenWidth > 400 ? .caption : .system(size: 9))
                                }
                            }else if collabSpace.whiteboardAmount > 0{
                                HStack(alignment: .top, spacing: 6){
                                    Image(systemName:"pencil.line").font(screenWidth > 400 ?.footnote : .system(size: 11))
                                    Text("\(collabSpace.whiteboardAmount) Whiteboard").font(screenWidth > 400 ? .caption : .system(size: 9))
                                }
                            }
                            if collabSpace.tableWhiteboardAmount > 1{
                                HStack(alignment: .top, spacing: 6){
                                    Image(systemName:"pencil.line").font(screenWidth > 400 ?.footnote : .system(size: 11))
                                    Text("\(collabSpace.tableWhiteboardAmount) Table Whiteboards").font(screenWidth > 400 ? .caption : .system(size: 9))
                                }
                            }else if collabSpace.tableWhiteboardAmount > 0{
                                HStack(alignment: .top, spacing: 6){
                                    Image(systemName:"pencil.line").font(screenWidth > 400 ?.footnote : .system(size: 11))
                                    Text("\(collabSpace.tableWhiteboardAmount) Table Whiteboard").font(screenWidth > 400 ? .caption : .system(size: 9))
                                }
                            }
                        }
                        .frame(maxWidth: screenWidth > 400 ? 88 : 70, alignment: .leading)
                        VStack(alignment: .leading, spacing:6){
                            Text("Capacity").font(screenWidth > 400 ? .caption : .system(size: 9)).foregroundColor(.gray)
                            HStack(spacing: 6){
                                Image(systemName:"person").font(screenWidth > 400 ?.footnote : .system(size: 11))
                                Text("\(collabSpace.capacity)").font(screenWidth > 400 ? .caption : .system(size: 9))
                            }
                        }
                        .frame(alignment: .leading)
                    }
                }
            }
            Divider().padding(.top, (-1)*geometrySize*0.015)
            VStack(alignment: .leading, spacing: 16){
                Text("Available timeslot").font(.system(.subheadline)).fontWeight(.medium)
                TimeslotManager(navigationPath: $navigationPath, collabSpace: .constant(collabSpace), selectedDate: .constant(selectedDate), geometrySize: geometrySize)
            }
            .padding(.top, geometrySize*0.025)
            .padding(.horizontal, 16)
            .padding(.bottom, 24)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                .background(Color.white)
                .cornerRadius(12)
                
        )
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

//#Preview {
//    let navigationPath = NavigationPath()
//    CollabspaceCard(navigationPath: .constant(navigationPath), collabSpace: .constant(CollabSpace(
//        name: "Collab Space 04",
//        capacity: 8, whiteboardAmount: 2, tableWhiteboardAmount: 2, tvAvailable: true, image: "collab-04-img")), selectedDate: .constant(Date()))
//}



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
