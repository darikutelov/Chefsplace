//
//  RegisterView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import SwiftUI

struct RegisterView: View {
    enum Field: Hashable {
            case emailField
            case passwordField
        }
    
    @ObservedObject var viewModel = RegisterViewViewModel()
    @FocusState private var focusedField: Field?
    
    var body: some View {
        ZStack {
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
                                showPlaceHolder: $viewModel.email.wrappedValue.isEmpty,
                                placeholder: String(localized: "email_label")
                            )
                        )
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                        .overlay(
                            RoundedRectangle(cornerRadius: Constants.Spacing.standard)
                                .stroke(
                                    getFieldBorderColor(viewModel.emailFieldStatus),
                                    lineWidth: Constants.Spacing.xxsmall
                                )
                        )
                        .padding(.vertical, Constants.Spacing.small)
                    
                    PasswordInputField(
                        password: $viewModel.password
                    )
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.Spacing.standard)
                            .stroke(
                                getFieldBorderColor(viewModel.passwordFieldStatus),
                                lineWidth: Constants.Spacing.xxsmall
                            )
                    )
                    .padding(.bottom, Constants.Spacing.small)
                    
                    PasswordInputField(
                        password: $viewModel.rePassword
                    )
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.Spacing.standard)
                            .stroke(
                                getFieldBorderColor(viewModel.rePasswordFieldStatus),
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
                    .ignoresSafeArea(.all)
            )
            .onAppear {
                focusedField = .emailField
            }
            
            if !viewModel.errorMessage.isEmpty {
                VStack {
                    Spacer()
                    AuthErrorView(message: viewModel.errorMessage)
                        .padding()
                }
            }
        }
    }
    
    private func getFieldBorderColor(_ fieldStatus: InputFieldStatus) -> Color {
        switch fieldStatus {
        case .clear:
            return Color.clear
        case .error:
            return Constants.Colors.error
        case .valid:
            return Constants.Colors.primary
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
