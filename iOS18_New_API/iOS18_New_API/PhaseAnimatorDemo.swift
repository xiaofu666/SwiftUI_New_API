//
//  PhaseAnimatorDemo.swift
//  iOS18_New_API
//
//  Created by Xiaofu666 on 2024/9/18.
//

import SwiftUI

struct PhaseAnimatorDemo: View {
    @State private var password: String = ""
    @State private var wrongPasswordTrigger: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Account Password")
                .font(.caption)
                .foregroundStyle(.gray)
            
            SecureField("Password", text: $password)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .frame(width: 250)
                .phaseAnimator([0, 8, -8, 4, -4, 0], trigger: wrongPasswordTrigger) { content, offset in
                    content
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(wrongPasswordTrigger ? Color.red.opacity(0.1) : Color.primary.opacity(0.06))
                        }
                        .offset(x: wrongPasswordTrigger ? offset : 0)
                } animation: { _ in
                        .snappy(duration: 0.13).speed(1.5)
                }
                .onChange(of: password) { oldValue, newValue in
                    wrongPasswordTrigger = false
                }

            
            Button {
                wrongPasswordTrigger = true
            } label: {
                Text("Login")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 2)
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .padding(.top, 15)
        }
    }
}

#Preview {
    PhaseAnimatorDemo()
}
