//
//  CollabspaceCardManager.swift
//  cobo-personal
//
//  Created by Amanda on 26/03/25.
//
import SwiftUI
struct CollabspaceCardManager : View{
    @Environment(\.modelContext) var modelContext
    
    @Binding var navigationPath: NavigationPath
    @Binding var selectedDate: Date
    var geometrySize:CGFloat
    var collabSpaceController = CollabSpaceController()
    @State var collabSpaces: [CollabSpace] = []
    
    
    var body: some View{
        ScrollView(.vertical){
            LazyVStack(spacing: 32){
                ForEach(collabSpaces, id: \.self){
                    collabspace in
                    CollabspaceCard(navigationPath: $navigationPath, collabSpace: .constant(collabspace), selectedDate: .constant(selectedDate), geometrySize: geometrySize)
                }
                
            }.padding(12)
            
        }
        .onAppear() {
            collabSpaceController.setupModelContext(self.modelContext)
            collabSpaces = collabSpaceController.getAllCollabSpace()
        }
    }
}

//#Preview {
//    let navigationPath = NavigationPath()
//    CollabspaceCardManager(navigationPath: .constant(navigationPath), selectedDate: .constant(Date()))
//}
