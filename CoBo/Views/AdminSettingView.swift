//
//  AdminSettingView.swift
//  CoBo
//
//  Created by Evan Lokajaya on 20/04/25.
//

import SwiftUI

struct AdminSettingView: View {
    @Binding var navigationPath: NavigationPath
    
    @State var showAdminTotpSheet = false
    
    var body: some View {
        List {
            AdminSettingItemComponent(image: "gearshape.fill", title: "General Setting")
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            AdminSettingItemComponent(image: "folder.fill", title: "Booking Log")
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            AdminSettingItemComponent(image: "key.fill", title: "Admin Access")
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .onTapGesture {
                openSheetAdminAccessCode()
            }
            
            .listRowSeparator(.visible, edges: .bottom)
        }
        .listStyle(PlainListStyle())
        .scrollDisabled(true)
        .background(Color.white)
        .safeAreaPadding()
        .padding(.horizontal, 16)
        
        .navigationTitle("Admin Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
        
        .sheet(isPresented: $showAdminTotpSheet) {
            let secretKey = "MYYHC33XJBLVE3RYKU4UG4LZGRZXK42M"
            let provisioningUri = TotpUtil.getProvisioningUri(for: secretKey, username: "Admin")
            let image = generateQRCode(for: provisioningUri)
            AdminTotpQRView(image: image)
        }
    }
    
    func navigateToGeneralSetting() {
        print("Navigate to General Setting")
    }
    
    func navigateToAdminBookingLog() {
        print("Navigate to Admin Booking Log")
    }
    
    func openSheetAdminAccessCode() {
        showAdminTotpSheet = true
    }
    
    func generateQRCode(for value: String) -> Image? {
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        
        guard let data = value.data(using: .utf8) else { return nil }
        filter.message = data
        filter.correctionLevel = "M"
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return Image(decorative: cgImage, scale: 1)
            }
        }
        
        return nil
    }
}

struct AdminSettingItemComponent: View {
    var image: String
    var title: String
    
    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 35, height: 35)
                .background(Color.blue)
                .cornerRadius(5)
                .padding(.leading, 16)
                .padding(.vertical, 16)
            
            Text(title)
                .font(.system(size: 20))
                .foregroundColor(.black)
                .padding(.leading, 8)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 20))
                .foregroundColor(Color.gray)
                .padding(.trailing, 16)
        }
        .frame(height: 60)
        .background(Color.white)
    }
}

#Preview {
    @Previewable @State var navPath = NavigationPath()
    AdminSettingView(navigationPath: $navPath)
}
