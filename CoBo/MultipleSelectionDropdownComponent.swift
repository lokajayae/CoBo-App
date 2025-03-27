//
//  MultipleSelectionDropdownComponent.swift
//  CoBo
//
//  Created by Evan Lokajaya on 26/03/25.
//

import SwiftUI

struct MultipleSelectionDropdownComponent<T:DropdownProtocol>: View {
    
    @Binding var selectedData: [T]
    let allData: [T]
    let itemColor: Color
    
    @State var isDropdownExpanded = false
    @State var searchText: String = ""
    var filteredData: [T] {
        allData.filter { item in
            guard !selectedData.contains(where: { $0.dropdownLabel == item.dropdownLabel }) else {
                return false
            }
            
            if searchText.isEmpty {
                return true
            }
            
            // searchText has content, so check if description contains the search text
            return item.dropdownLabel.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    
    init(selectedData: Binding<[T]>, allData: [T]) {
        self._selectedData = selectedData
        self.allData = allData
        self.itemColor = .blue
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TagPlacer(spacing: 8) {
                ForEach(selectedData) { data in
                    MultipleSelectionItemComponent(item: data, color: itemColor){
                        if let index = selectedData.firstIndex(where: { $0.dropdownLabel == data.dropdownLabel }) {
                            selectedData.remove(at: index)
                        }
                    }
                }
            }
            Button {
                isDropdownExpanded.toggle()
                searchText = ""
            } label: {
                Text("+ Add Participant")
            }
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.lightYellow) // Light cream/yellow color
                )
                .frame(maxWidth: .infinity, alignment: .leading)
            if (isDropdownExpanded) {
                VStack {
                    TextField("Search...", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    if filteredData.isEmpty {
                        Text("No results found")
                            .foregroundColor(.gray)
                            .padding()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 0) {
                                ForEach(filteredData) { item in
                                    Text(item.dropdownLabel)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                        .contentShape(Rectangle())
                                        .onTapGesture {
                                            selectedData.append(item)
                                            isDropdownExpanded = false
                                            searchText = ""
                                        }
                                        .background(Color.white)
                                    Divider()
                                }
                            }
        
                            
                        }
                    }
                }
                .frame(maxHeight: 300)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 5)
//                .offset(y: 60)
                .transition(.opacity)
                .zIndex(9999)
            }
        }
    }
}

struct MultipleSelectionItemComponent<T: DropdownProtocol>: View {
    let item: T
    let color: Color
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Text(item.dropdownLabel)
                .font(.system(size: 14))
                .foregroundColor(.white)
            
            Button(action: onRemove) {
                Image(systemName: "xmark")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 10)
        .background(color)
        .cornerRadius(16)
    }
}

struct TagPlacer: Layout {
    var spacing: CGFloat
    
    init(spacing: CGFloat = 8) {
        self.spacing = spacing
    }
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var position = CGPoint.zero
        var maxHeight: CGFloat = 0
        var rowMaxHeight: CGFloat = 0
        
        for (i, size) in sizes.enumerated() {
            // Check if we need to move to a new row
            if i > 0 && position.x + size.width > proposal.width ?? .infinity {
                position.x = 0
                position.y += rowMaxHeight + spacing
                rowMaxHeight = 0
            }
            
            // Update position for next item
            position.x += size.width + spacing
            rowMaxHeight = max(rowMaxHeight, size.height)
            maxHeight = max(maxHeight, position.y + size.height)
        }
        
        return CGSize(width: proposal.width ?? .infinity, height: maxHeight)
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let sizes = subviews.map { $0.sizeThatFits(.unspecified) }
        
        var position = bounds.origin
        var rowMaxHeight: CGFloat = 0
        
        for (i, subview) in subviews.enumerated() {
            let size = sizes[i]
            
            // Check if we need to move to a new row
            if i > 0 && position.x + size.width > bounds.maxX {
                position.x = bounds.origin.x
                position.y += rowMaxHeight + spacing
                rowMaxHeight = 0
            }
            
            // Place the subview
            subview.place(at: position, proposal: .unspecified)
            
            // Update position for next item
            position.x += size.width + spacing
            rowMaxHeight = max(rowMaxHeight, size.height)
        }
    }
}

struct Rasa: View {
    @State private var selectedItems: [User] = [DataManager.getUsersData()[1]]
    let allItems: [User] = DataManager.getUsersData()
    
    var body: some View {
        VStack(alignment: .leading) {
            MultipleSelectionDropdownComponent(selectedData: $selectedItems, allData: allItems)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    Rasa()
}
