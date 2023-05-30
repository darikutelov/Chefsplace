//
//  RegisterView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text(String(localized: "signup_label").uppercased())
                .font(Font.custom(
                    Constants.Fonts.headingFont,
                    size: Constants.Spacing.xxlarge
                ))
                .kerning(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                .foregroundColor(Constants.Colors.charcoal)
                .padding(Constants.Spacing.small)
            
            VStack {
                TextField(String(localized: "email_label"), text: $viewModel.email)
                    .modifier(
                        InputFieldWhithBg(error: !viewModel.errorMessage.isEmpty)
                    )
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .padding(.vertical, Constants.Spacing.small)
                
                PasswordInputField(
                    error: $viewModel.errorMessage,
                    password: $viewModel.password
                )
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .padding(.bottom, Constants.Spacing.small)
                
                PasswordInputField(
                    error: $viewModel.errorMessage,
                    password: $viewModel.rePassword
                )
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .padding(.bottom, Constants.Spacing.small)
                
                HStack {
                    Spacer()
                    Button {
                        viewModel.errorMessage = ""
                        viewModel.register()
                    } label: {
                        CustomButton(
                            buttonText: viewModel.isLoading ?
                            "Loading" :
                                String(localized: "signup_label"),
                            buttonBackgroundColor: Constants.Colors.primary,
                            iconName: Constants.IconNames.register,
                            buttonWidth: Constants.Spacing.maxFormFieldWidth
                        )
                    }
                    Spacer()
                }
                .padding(.bottom, Constants.Spacing.small)
            }
            .padding()
            .background {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Constants.Colors.charcoal.opacity(0.95),
                                Constants.Colors.charcoal
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        
                    )
                .cornerRadius(Constants.Spacing.standardPlus)
                    .frame(maxWidth: 350)
            }
            Spacer()
        }
        .background(
            Image(Constants.Images.registerBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
        )
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
