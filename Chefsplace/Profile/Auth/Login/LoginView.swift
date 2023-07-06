//
//  LoginView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import SwiftUI

struct LoginView: View {
    // Environment and Observed
    @StateObject var viewModel = LoginViewViewModel()
    
    // State & Bindings
    @Binding var isPresented: Bool
    @FocusState private var focusedField: Field?
    @State private var isEmailPristine = true
    @State private var isPasswordPristine = true
    
    var body: some View {
        NavigationView {
            ZStack {
                Constants.Colors.authBg
                    .ignoresSafeArea(.all)
                  
                VStack {
                    DismissButton(isPresented: $isPresented)
                    Spacer()
                    
                    Text(String(localized: "signin_label").uppercased())
                        .font(Font.custom(
                            Constants.Fonts.headingFont,
                            size: Constants.Spacing.xxlarge
                        ))
                        .kerning(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Constants.Colors.charcoal)
                        .padding(Constants.Spacing.small)
                    
                    VStack {
                        TextField("", text: $viewModel.email)
                            .focused($focusedField, equals: .emailField)
                            .modifier(
                                InputFieldWhithBg(
                                    showPlaceHolder: $viewModel.email.wrappedValue.isEmpty,
                                    placeholder: String(localized: "email_label")
                                )
                            )
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .onChange(of: viewModel.email) { _, _ in
                                isEmailPristine = false
                            }
                            .onSubmit {
                                focusedField = .passwordField
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: Constants.Spacing.standard)
                                    .stroke(
                                        viewModel.getFieldBorderColor(
                                            viewModel.emailFieldStatus,
                                            isPristine: isEmailPristine
                                        ),
                                        lineWidth: Constants.Spacing.xxsmall
                                    )
                            )
                            .padding(.vertical, Constants.Spacing.small)
                        
                        PasswordInputField(
                            password: $viewModel.password
                        )
                        .focused($focusedField, equals: .passwordField)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .onChange(of: viewModel.email) { _, _ in
                            isPasswordPristine = false
                        }
                        .overlay(
                            RoundedRectangle(cornerRadius: Constants.Spacing.standard)
                                .stroke(
                                    viewModel.getFieldBorderColor(
                                        viewModel.passwordFieldStatus,
                                        isPristine: isPasswordPristine
                                    ),
                                    lineWidth: Constants.Spacing.xxsmall
                                )
                        )
                        .padding(.bottom, Constants.Spacing.small)
                        
                        HStack {
                            Spacer()
                            Button {
                                viewModel.errorMessage = ""
                                Task {
                                    await viewModel.login()
                                }
                            } label: {
                                CustomButton(
                                    isLoading: $viewModel.isLoading,
                                    buttonText: viewModel.isLoading ?
                                    "Loading" :
                                        String(localized: "signin_label"),
                                    buttonBackgroundColor: Constants.Colors.primary,
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
                                    .foregroundColor(Constants.Colors.terciary.opacity(0.75))
                                    .padding(.trailing, Constants.Spacing.small)
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
                    VStack {
                        Image(Constants.Images.loginBg)
                            .resizable()
                            .scaledToFill()
                            .rotationEffect(Angle(degrees: -45))
                            .ignoresSafeArea(.all)
                            .offset(x: -50)
                        Spacer()
                    }
                )
            }
            .onAppear {
                focusedField = .emailField
            }
            .onDisappear {
                viewModel.resetState()
            }
        }
    }
}

struct DismissButton: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        HStack {
           
            Button {
                isPresented = false
            } label: {
                Image(systemName: Constants.IconNames.arrowBack)
                    .foregroundColor(Constants.Colors.charcoal)
                    .font(.title)
                    .padding(.leading, 24)
            }
            Spacer()
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(isPresented: .constant(true))
    }
}
