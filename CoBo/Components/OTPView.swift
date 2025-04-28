
import SwiftUI
import Combine


struct OTPFieldComponent: View {
    @FocusState private var pinFocusState: FocusPin?
    @Binding private var otp: String
    @State private var pins: [String]
    
    var numberOfFields: Int
    
    enum FocusPin: Hashable {
        case pin(Int)
    }
    
    init(numberOfFields: Int, otp: Binding<String>) {
        self.numberOfFields = numberOfFields
        self._otp = otp
        self._pins = State(initialValue: Array(repeating: "", count: numberOfFields))
    }
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<numberOfFields, id: \.self) { index in
                TextField("", text: $pins[index])
                    .modifier(OtpModifier(pin: $pins[index]))
                    .foregroundColor(Color.black)
                    .font(.title)
                    .keyboardType(.numberPad)
                    .onChange(of: pins[index]) { newVal in
                        if newVal.count == 1 {
                            if index < numberOfFields - 1 {
                                pinFocusState = .pin(index + 1)
                            } else {
                                pinFocusState = nil
                            }
                        } else if newVal.count == numberOfFields {
                            otp = newVal
                            updatePinsFromOTP()
                            pinFocusState = nil
                        } else if newVal.isEmpty {
                            if index > 0 {
                                pinFocusState = .pin(index - 1)
                            }
                        }
                        updateOTPString()
                    }
                    .focused($pinFocusState, equals: FocusPin.pin(index))
                    .onTapGesture {
                        pinFocusState = FocusPin.pin(index)
                    }
            }
        }
        .onAppear {
            updatePinsFromOTP()
        }
        .onChange(of: otp) { newValue in
            if newValue.isEmpty {
                pins = Array(repeating: "", count: numberOfFields)
            }
        }
    }
    
    private func updatePinsFromOTP() {
        let otpArray = Array(otp.prefix(numberOfFields))
        for (index, char) in otpArray.enumerated() {
            pins[index] = String(char)
        }
    }
    
    private func updateOTPString() {
        otp = pins.joined()
    }
}

struct OtpModifier: ViewModifier {
    @Binding var pin: String
    
    var textLimit = 1
    
    func limitText(_ upper: Int) {
        if pin.count > upper {
            self.pin = String(pin.prefix(upper))
        }
    }
    
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) { _ in limitText(textLimit) }
            .frame(width: 44, height: 60)
            .font(.title)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color(.systemGray6))
                    .stroke(Color(.systemGray6), lineWidth: 1)
            )
    }
}



