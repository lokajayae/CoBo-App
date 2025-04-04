import SwiftUI

struct BookingSuccessView: View {
    @State private var shadowRadius: CGFloat = 5
    @State var isPresented = false
    var checkInTime: String
    var bookingDate: String
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack{
                    ZStack{
                        circleShape()
                            .fill(Color(red: 33/255, green: 216/255, blue: 79/255))
                            .frame(width: 80, height: 80)
                            .offset(x: 0, y: 0)
                            .shadow(color: .green, radius: shadowRadius)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                    shadowRadius = 15}}
                        checkmarkShape()
                            .stroke(Color.white, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                            .frame(width: 65, height: 65)
                        .offset(x: 0, y: 0)}
                    Spacer()
                    ZStack {
                        circleBGShape()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 255 / 255, green: 233 / 255, blue: 130 / 255), Color.white]),
                                               startPoint: .leading,
                                               endPoint: .trailing))
                            .frame(width: 165, height: 165)
                            .offset(x: 30, y: -140)
                            .opacity(0.4)
                            .padding(.bottom, -50)
                        
                        circleBGShape2()
                            .fill(
                                LinearGradient(gradient: Gradient(colors: [Color(red: 238 / 255, green: 183 / 255, blue: 255 / 255), Color.white]),
                                               startPoint: .top,
                                               endPoint: .bottom))
                            .frame(width: 191.28, height: 191.28)
                            .offset(x: 115, y: -60)
                            .opacity(0.4)
                            .padding(.bottom, -50)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
        
                Text("Your booking has been placed!")
                    .bold()
                    .font(.system(size: 17, design: .default))
                Text("Now save this code")
                    .bold(true)
                    .padding(.bottom,10)
                    .font(.system(size: 17, design: .default))
                VStack(alignment: .leading){
                    HStack{
                        Text("This code won't be shown again.")
                            .font(.system(size: 13, design: .default))
                            .foregroundColor(Color(red: 127/255, green: 41/255, blue: 154/255))
                            .italic(true)
                            .bold(true)
                        
                        Text("Save this 6-digit code")
                            .font(.system(size: 13))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Text("for future check-in to verify your attendance.")
                        .font(.system(size: 13))
                }
                CodeDisplayView()
                HStack{
                    Button(action: {
                        isPresented = true
                    }) {
                        HStack {
                            Text("Want to add this to iCal?")
                                .bold()
                                .foregroundColor(Color(red: 127/255, green: 41/255, blue: 154/255))
                                .frame(width: 300, height: 50, alignment: .leading)
                                .font(.system(size: 13, design: .default))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundStyle(.gray)
                        }
                        .padding(.horizontal)
                    }
                    .background(Color(red: 250/255, green: 233/255, blue: 255/255))
                    .frame(width: 370, height: 50)
                    .cornerRadius(10)
                    .opacity(0.6)
                    
                }
                .sheet(isPresented: $isPresented) {
                    ModalView()
                        .presentationDetents([.height(400)])
                        .presentationCornerRadius(25)
                }
                
                Text("Check-In Time")
                    .padding(.bottom,10)
                    .padding(.top,10)
                    .bold(true)
                    .font(.system(size: 15))
                HStack{
                    Text("Available on")
                        .font(.system(size: 15))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                    Text(checkInTime + ".")
                        .bold()
                        .font(.system(size: 15))
                        .multilineTextAlignment(.trailing)
                        .fixedSize(horizontal: false, vertical: true)
                    
                }
                HStack{
                    Image(systemName:"info.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.red, .red)
                        .padding(.bottom,25)
                    Text("Please note that late check-in will cause your booking to be cancelled")
                        .foregroundStyle(.secondary)
                        .padding(.bottom, 15)
                        .font(.system(size: 13))
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Text("Booking Summary")
                    .bold(true)
                    .padding(.bottom,15)
                    .font(.system(size: 15))
                HStack{
                    Text("Date")
                        .font(.system(size: 14))
                    Spacer()
                    Text(bookingDate)
                        .bold()
                        .font(.system(size: 14))
                }
                Divider()
                    .background(Color(UIColor(red: 0xD9/255, green: 0xD9/255, blue: 0xD9/255, alpha: 1.0)))
                    .padding(.bottom, 32)
                NavigationLink(destination: ContentView()) {
                    Text("Back to Home Page")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color("Purple"),
                                    Color("Medium-Purple")
                                ]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(24)
                        .padding(.horizontal, 12)
                        .padding(.top, 24)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                    }
                })
            }
            .safeAreaPadding()
        }
    }
}


#Preview {
    BookingSuccessView(checkInTime: "Monday, March 25 2025 (07.55 - 08.10 AM)", bookingDate: "Monday, March 25 2025")
}
