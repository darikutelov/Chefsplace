//
//  AuthViewModel.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 5.06.23.
//

import Foundation
import SwiftUI

enum Field: Hashable {
    case emailField
    case passwordField
    case rePasswordField
}

class AuthViewModel {
    @MainActor @Published var errorMessage = ""
    @MainActor @Published var isLoading = false
    
    @Published var email: String = "" {
        willSet {
            print(email)
            setEmailFieldStatus(email)
        }
    }
    @Published var password = "" {
        willSet {
            setPasswordFieldStatus(password)
        }
        
    }
    
    @MainActor @Published var emailFieldStatus = InputFieldStatus.clear
    @MainActor @Published var passwordFieldStatus = InputFieldStatus.clear
    
    @MainActor func validateAuthField(_ text: String, regexPattern: String = "") -> InputFieldStatus {
        if text.trimmingCharacters(in: .whitespaces).isEmpty {
            return .error
        }
        
        if !regexPattern.isEmpty {
            guard let emailRegex = try? NSRegularExpression(pattern: regexPattern) else {
                return .error
            }
            
            let range = NSRange(location: 0, length: text.utf16.count)
            let matches = emailRegex.firstMatch(in: text, options: [], range: range)
            
            if matches == nil {
                return .error
            }
        }
        
        return .valid
    }
    
    func getFieldBorderColor(_ fieldStatus: InputFieldStatus, isPristine: Bool) -> Color {
        guard !isPristine else {
            return Color.clear
        }
        
        switch fieldStatus {
        case .clear:
            return Color.clear
        case .error:
            return Constants.Colors.error
        case .valid:
            return Constants.Colors.primary
        }
    }
    
    @MainActor func resetState() {
        email = ""
        password = ""
        errorMessage = ""
        isLoading = false
        emailFieldStatus = InputFieldStatus.clear
        passwordFieldStatus = InputFieldStatus.clear
    }
    
    private func setEmailFieldStatus(_ email: String) {
        Task {@MainActor in
            emailFieldStatus = validateAuthField(
                email,
                regexPattern: Constants.ValidationRegex.email
            )
        }
    }
    
    private func setPasswordFieldStatus(_ password: String) {
            Task {@MainActor in
                passwordFieldStatus = validateAuthField(
                    password,
                    regexPattern: Constants.ValidationRegex.password
                )
            }
    }
}
