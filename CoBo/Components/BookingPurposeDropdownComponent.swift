//
//  DropdownComponent.swift
//  CoBo
//
//  Created by Evan Lokajaya on 04/04/25.
//

import SwiftUI

import SwiftUI
import SwiftData

struct BookingPurposeDropdownComponent: View {
    @State private var isExpanded = false
    @State private var dropdownLabel: String
    @Binding private var selectedItem: BookingPurpose?
    
    let lightGrayColor = Color(red: 243/255, green: 243/255, blue: 243/255)
    
    var data: [BookingPurpose] = BookingPurpose.allValues
    
    init(selectedItem: Binding<BookingPurpose?>) {
        self._selectedItem = selectedItem
        self._dropdownLabel = State(initialValue: selectedItem.wrappedValue?.rawValue ?? "Select an Option")
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
                            .font(.callout)
                            .foregroundStyle(Color.black)
                        Spacer()
                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundStyle(Color.darkPurple)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 14)
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
                    ScrollView {
                        LazyVStack(spacing: 0) {
                            ForEach(data, id: \.self) { item in
                                Text(item.rawValue)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding()
                                    .font(.system(size:13))
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        dropdownLabel = item.rawValue
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
                .frame(maxHeight: 200)
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

struct DropdownComponentTestView: View {
    @State var selectedValue: BookingPurpose? = nil
    var users = DataManager.getUsersData()
    
    var body: some View {
        BookingPurposeDropdownComponent(selectedItem: $selectedValue)
    }
}

#Preview {
    DropdownComponentTestView()
}
