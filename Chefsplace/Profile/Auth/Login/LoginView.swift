//
//  LoginView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import SwiftUI

struct LoginView: View {
    @Binding var isPresented: Bool
    @StateObject var viewModel = LoginViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                DismissButton(isPresented: $isPresented)
                Spacer()
                Text(String(localized: "signin_label").uppercased())
                    .font(Font.custom(
                        Constants.Fonts.headingFont,
                        size: Constants.Spacing.xxlarge
                    ))
                    .kerning(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Constants.Colors.terciary)
                    .padding(Constants.Spacing.small)
                
                VStack {
                    TextField("", text: $viewModel.email)
                        .modifier(
                            InputFieldWhithBg(
                                error: !viewModel.errorMessage.isEmpty,
                                showPlaceHolder: $viewModel.email.wrappedValue.isEmpty,
                                placeholder: String(localized: "email_label")
                            )
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
                    
                    HStack {
                        Spacer()
                        Button {
                            viewModel.errorMessage = ""
                            viewModel.login()
                        } label: {
                            CustomButton(
                                isLoading: $viewModel.isLoading,
                                buttonText: viewModel.isLoading ?
                                "Loading" :
                                    String(localized: "signin_label"),
                                buttonBackgroundColor: Constants.Colors.charcoal,
                                iconName: Constants.IconNames.login,
                                buttonWidth: Constants.Spacing.maxFormFieldWidth
                            )
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        NavigationLink(destination: RegisterView()) {
                            Text(String(localized: "forgot_password_label"))
                                .foregroundColor(Constants.Colors.charcoal)
                        }
                    }
                    .frame(maxWidth: 300)
                    NavigationLink(destination: RegisterView()) {
                        Text(String(localized: "new_account_label"))
                            .foregroundColor(Constants.Colors.terciary)
                            .padding(.vertical, Constants.Spacing.small)
                    }
                }
                .padding()
                .background {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Constants.Colors.primary.opacity(0.95),
                                    Constants.Colors.primary
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
                Image(Constants.Images.loginBg)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
            )
        }
    }
}

struct DismissButton: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                isPresented = false
            } label: {
                Image(systemName: "xmark.circle")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding(.trailing, 24)
            }
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isPresented: .constant(true))
    }
}
