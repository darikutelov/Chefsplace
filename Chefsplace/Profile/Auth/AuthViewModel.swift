//
//  AuthViewModel.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 5.06.23.
//

import Foundation

class AuthViewModel {
    @MainActor @Published var errorMessage = ""
    @MainActor @Published var isLoading = false
    
    @Published var email = "" {
        willSet {
            Task {@MainActor in
                emailFieldStatus = validateAuthField(
                    email,
                    regexPattern: Constants.ValidationRegex.email
                )
            }
        }
    }
    @MainActor @Published var emailFieldStatus = InputFieldStatus.clear
    
    @Published var password = "" {
        willSet {
            Task {@MainActor in
                passwordFieldStatus = validateAuthField(
                    password,
                    regexPattern: Constants.ValidationRegex.password
                )
            }
        }
    }
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
    
    @MainActor func resetState() {
        email = ""
        password = ""
        errorMessage = ""
        isLoading = false
        emailFieldStatus = InputFieldStatus.clear
        passwordFieldStatus = InputFieldStatus.clear
    }
}
