//
//  SerachableDropdownComponent.swift
//  CoBo
//
//  Created by Evan Lokajaya on 26/03/25.
//

import SwiftUI
import SwiftData

struct SearchableDropdownComponent<T:DropdownProtocol>: View {
    @State private var isExpanded = false
    @State private var dropdownLabel = "Select an Option"
    @State private var searchText = ""
    @Binding private var selectedItem: T?
    
    let lightGrayColor = Color(red: 243/255, green: 243/255, blue: 243/255)
    
    var data: [T]
    
    var filteredData: [T] {
        if searchText.isEmpty {
            return self.data
        } else {
            return self.data.filter { $0.dropdownLabel.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    init(selectedItem: Binding<T?>, data: [T]) {
        self.data = data
        self._selectedItem = selectedItem
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    HStack {
                        Text(dropdownLabel)
                            .lineLimit(1)
                            .foregroundStyle(Color.black)
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundStyle(Color.darkPurple)
                    }
                    .frame(width: .infinity, height: 10)
                    .padding()
                    .background(Color.clear)
                    .border(lightGrayColor)
                    .cornerRadius(3)
                }
                
                Spacer()
                    .frame(height: isExpanded ? 300 : 0)
            }
            
            if isExpanded {
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
                                            dropdownLabel = item.dropdownLabel
                                            selectedItem = item
                                            withAnimation {
                                                isExpanded = false
                                            }
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
                .offset(y: 60)
                .transition(.opacity)
                .zIndex(999)
            }
        }
        .background(
            isExpanded ?
                Color.black.opacity(0.001)
                    .onTapGesture {
                        withAnimation {
                            isExpanded = false
                        }
                    }
                    .ignoresSafeArea()
                : nil
        )
    }
}

struct SearchableComponentTestView: View {
    @State var selectedUser: User? = nil
    var users = DataManager.getUsersData()
    
    var body: some View {
        SearchableDropdownComponent(selectedItem: $selectedUser, data: users)
    }
}

#Preview {
    SearchableComponentTestView()
}
