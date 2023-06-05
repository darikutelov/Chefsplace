//
//  PasswordInputField.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 29.05.23.
//

import SwiftUI

struct PasswordInputField: View {
    let fieldLabel = String(localized: "password_label")
    @Binding var password: String
    @State var showPassword = false
    
    var body: some View {
        ZStack(alignment: .center) {
            Group {
                if showPassword {
                    TextField(fieldLabel, text: $password)
                    
                } else {
                    SecureField(fieldLabel, text: $password)
                }
            }
            .modifier(
                InputFieldWhithBg(
                showPlaceHolder: password.isEmpty,
                placeholder: String(localized: "password_label")
                )
            )
            
            HStack {
                Spacer()
                Button {
                    showPassword.toggle()
                } label: {
                    if showPassword {
                        Image(systemName: Constants.IconNames.visiblePasswordIcon)
                            .foregroundColor(Constants.Colors.secondary)
                    } else {
                        Image(systemName: Constants.IconNames.notVisiblePasswordIcon)
                            
                            .foregroundColor(Constants.Colors.secondary)
                    }
                }
                .padding(.trailing, 6.0)
            }.frame(maxWidth: Constants.Spacing.maxFormFieldWidth)
        }
    }
}

struct PasswordInputField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordInputField(password: .constant("123456"))
    }
}
