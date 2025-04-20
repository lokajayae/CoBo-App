//
//  AdminCodeView.swift
//  CoBo
//
//  Created by Evan Lokajaya on 19/04/25.
//

import SwiftUI

struct AdminCodeView: View {
    @Binding var codeInput: String
    @Binding var errorMessage: String?
    var onConfirm: () -> Void

    @FocusState private var focusedField: Int?

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("Enter the Admin Code to proceed")
                    .font(.title3)
                    .bold()
                    .multilineTextAlignment(.center)

                HStack(spacing: 12) {
                    ForEach(0..<6, id: \.self) { index in
                        CodeBox(index: index, code: $codeInput)
                            .focused($focusedField, equals: index)
                            .onChange(of: codeInput) { _ in
                                focusedField = codeInput.count < 6 ? codeInput.count : nil
                            }
                    }
                }

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }

                Button(action: onConfirm) {
                    Text("Proceed")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.vertical, 16)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(24)
                        .padding(.horizontal, 12)
                        .padding(.top, 12)
                }

                Spacer()
            }
            .padding()
            .onAppear { focusedField = 0 }
        }
    }
}

#Preview {
    @Previewable @State var cancelCodeInput = ""
    @Previewable @State var cancelErrorMessage: String? = nil
    
    func validateCancelCode() {
        print("Validate Cancel Code")
    }
    
    return AdminCodeView(
        codeInput: $cancelCodeInput,
        errorMessage: $cancelErrorMessage,
        onConfirm: validateCancelCode
    )
}

