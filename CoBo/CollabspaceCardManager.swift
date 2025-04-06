//
//  CollabspaceCardManager.swift
//  cobo-personal
//
//  Created by Amanda on 26/03/25.
//
import SwiftUI
struct CollabspaceCardManager : View{
    @Binding var navigationPath: NavigationPath
    @Binding var selectedDate: Date
    @State var collabSpaces: [CollabSpace] = DataManager.getCollabSpacesData()
    
    var body: some View{
        ScrollView(.vertical){
            LazyVStack(spacing: 32){
                ForEach(collabSpaces, id: \.self){
                    collabspace in
                    CollabspaceCard(navigationPath: $navigationPath, collabSpace:
                            .constant(CollabSpace(name: collabspace.name,
                                                   capacity: collabspace.capacity,
                                                   whiteboardAmount: collabspace.whiteboardAmount,
                                                   tableWhiteboardAmount: collabspace.tableWhiteboardAmount,
                                                  tvAvailable: collabspace.tvAvailable, image: collabspace.image  )), selectedDate: .constant(selectedDate))
                }
                
                
                
            }.padding(12)
            
        }
    }
}

#Preview {
    let navigationPath = NavigationPath()
    CollabspaceCardManager(navigationPath: .constant(navigationPath), selectedDate: .constant(Date()))
}
