//
//  CheckinView.swift
//  CoBo
//
//  Created by Amanda on 27/03/25.
//
import SwiftUI
struct CheckinView: View {
    @Environment(\.modelContext) var modelContext
    var bookingController = BookingController()
    let screenWidth = UIScreen.main.bounds.width
    
    @State private var otp: String = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @FocusState private var isTextFieldFocused: Bool
    @State private var showAlert = false
    private let numberOfFieldsInOTP = 6
    @Environment(\.dismiss) private var dismissKeyboard
    
    var body: some View {
        GeometryReader{
            geometry in
            VStack(spacing: 0){
                ZStack(alignment: .top){
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white, Color.yellow.opacity(0.2)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: screenWidth > 400 ?  geometry.size.width * 0.55 : geometry.size.width * 0.60)
                    .cornerRadius(30, antialiased: true)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .ignoresSafeArea()
                    VStack{
                        VStack(alignment: .leading, spacing: geometry.size.height*0.01){
                            Text("🔑").font(.largeTitle).fontWeight(.bold)
                            Text("Check-in to Booking").font(screenWidth > 400 ? .title2 : .title3).fontWeight(.bold)
                            Text("Enter your 6-digit check-in code. Make sure you check-in between check-in time.").font(.callout)
                        }
                        .safeAreaPadding()
                        .padding(.horizontal, geometry.size.width*0.05)
                        .padding(.top, geometry.size.height*0.01)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // OTP Component
                        VStack{
                            OTPFieldComponent(numberOfFields: numberOfFieldsInOTP, otp: $otp)
                                .focused($isTextFieldFocused)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 54)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                isTextFieldFocused = true
                            }
                        }
                        Button(action: {
                            isTextFieldFocused = false
                            if otp == "" {
                                alertTitle = "Please input your check-in code!"
                            }else{
                                if let checkInResult = bookingController.checkInBooking(otp) {
                                                            alertTitle = checkInResult[0]
                                                            alertMessage = checkInResult[1]
                                                        }
                                
                            }
                            showAlert = true
                            }) {
                                Text("Check-in")
                                    .font(.system(.body , weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 16)
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        Color("Purple")
                                    )
                                    .cornerRadius(24)
                                    .padding(.horizontal, 12)
                                    .padding(.top, 16)
                            }
                            .padding(.top, 16)
                            .padding(.horizontal, 16)
                            .alert(isPresented: $showAlert) {
                                Alert(
                                    title: Text(alertTitle),
                                    message: Text(alertMessage),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .onTapGesture {
                    isTextFieldFocused = false
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
            .onAppear(){
                bookingController.setupModelContext(self.modelContext)
            }
            .onDisappear {
                otp = ""
            }
        }
        
        
    }
    
}

#Preview {
    CheckinView()
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
