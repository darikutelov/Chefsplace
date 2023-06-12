//
//  RegisterView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import SwiftUI

struct RegisterView: View {
    // Environment and Observed
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel = RegisterViewViewModel()
    
    // State
    @FocusState private var focusedField: Field?
    @State private var isEmailPristine = true
    @State private var isPasswordPristine = true
    @State private var isRePasswordPristine = true
    
    var body: some View {
        ZStack {
            Constants.Colors.authBg
                .ignoresSafeArea(.all)
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
                    TextField("", text: $viewModel.email)
                        .focused($focusedField, equals: .emailField)
                        .modifier(
                            InputFieldWhithBg(
                                showPlaceHolder: $viewModel
                                    .email.wrappedValue.isEmpty,
                                placeholder: String(localized: "email_label")
                            )
                        )
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .onChange(of: viewModel.email, perform: { _ in
                            isEmailPristine = false
                        })
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
                    .onChange(of: viewModel.email, perform: { _ in
                        isPasswordPristine = false
                    })
                    .onSubmit {
                        focusedField = .rePasswordField
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
                    
                    PasswordInputField(
                        password: $viewModel.rePassword
                    )
                    .focused($focusedField, equals: .rePasswordField)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .onChange(of: viewModel.email, perform: { _ in
                        isRePasswordPristine = false
                    })
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.Spacing.standard)
                            .stroke(
                                viewModel.getFieldBorderColor(
                                    viewModel.rePasswordFieldStatus,
                                    isPristine: isRePasswordPristine
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
                                await viewModel.register()
                            }
                            
                        } label: {
                            CustomButton(
                                isLoading: $viewModel.isLoading,
                                buttonText: String(localized: "signup_label"),
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
                    .rotationEffect(Angle(degrees: -45))
                    .ignoresSafeArea(.all)
                    .offset(x: -50)
            )
            
            if !viewModel.errorMessage.isEmpty {
                VStack {
                    Spacer()
                    AuthErrorView(message: viewModel.errorMessage)
                        .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: Constants.IconNames.arrowBack)
                        .foregroundColor(Constants.Colors.charcoal)
                }
            }
        }
        .onAppear {
            focusedField = .emailField
        }
        .onDisappear {
            viewModel.resetState()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
