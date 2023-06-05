//
//  RegisterViewViewModel.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import SwiftUI
import Foundation
import FirebaseAuth

final class RegisterViewViewModel: ObservableObject {
    @Published var email = "" {
        willSet {
            Task {
                await validateEmail()
            }
        }
    }
    @Published var password = "" {
        willSet {
            Task {
                await validatePassword(password)
            }
        }
    }
    @Published var rePassword = "" {
        willSet {
            Task {
                await validateRePassword(rePassword)
            }
        }
    }
    @MainActor @Published var errorMessage = ""
    @MainActor @Published var isLoading = false
    @MainActor @Published var emailFieldStatus = InputFieldStatus.clear
    @MainActor @Published var passwordFieldStatus = InputFieldStatus.clear
    @MainActor @Published var rePasswordFieldStatus = InputFieldStatus.clear
    
    func register() async {
        guard await validate() else {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            
            await MainActor.run {
                errorMessage = ""
            }
            return
        }
        
        await MainActor.run {
            isLoading =  true
        }
        
        do {
            let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
            let user = authDataResult.user
            
            await insertUserRecord(id: user.uid)
            
            await MainActor.run {
                isLoading =  false
            }
        } catch {
            await MainActor.run {
                isLoading =  false
                withAnimation {
                    errorMessage = error.localizedDescription
                }
                print(errorMessage)
            }
            
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            
            await MainActor.run {
                errorMessage = ""
            }
        }
    }
    
    private func insertUserRecord(id: String) async {
        //        let newUser = User(
        //            id: id,
        //            name: name,
        //            email: email,
        //            jooined: Date().timeIntervalSince1970
        //        )
        //
        //        let db = Firestore.firestore()
        //        db.collection("users")
        //            .document(id)
        //            .setData(newUser.asDictionary())
    }
    
    @MainActor private func validate() -> Bool {
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = String(localized: "error_all_fields") + "."
            return false
        }
        
        let emailRegexPattern = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        guard let emailRegex = try? NSRegularExpression(pattern: emailRegexPattern) else {
            // Handle invalid regex pattern
            return false
        }
        
        let range = NSRange(location: 0, length: email.utf16.count)
        let matches = emailRegex.firstMatch(in: email, options: [], range: range)
        
        guard matches != nil else {
            errorMessage = String(localized: "error_valid_email") + "."
            return false
        }
        
        return true
    }
    
    @MainActor func validateEmail() {
        let emailRegexPattern = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        guard let emailRegex = try? NSRegularExpression(pattern: emailRegexPattern) else {
            emailFieldStatus = InputFieldStatus.error
            return
        }
        
        let range = NSRange(location: 0, length: email.utf16.count)
        let matches = emailRegex.firstMatch(in: email, options: [], range: range)
        
        if email.trimmingCharacters(in: .whitespaces).isEmpty || matches == nil {
            emailFieldStatus = InputFieldStatus.error
        } else {
            emailFieldStatus = InputFieldStatus.valid
        }
    }
    
    //    At least 8 characters long
    //    Contains at least one uppercase letter
    //    Contains at least one lowercase letter
    //    Contains at least one numeric digit
    //    Contains at least one special character from the set @$!%*?&
    @MainActor func validatePassword(_ text: String) {
        let passwordRegexPattern = "^(?=.*[A-Z])(?=.*[a-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        guard let passwordRegex = try? NSRegularExpression(pattern: passwordRegexPattern) else {
            passwordFieldStatus = InputFieldStatus.error
            return
        }
        
        let range = NSRange(location: 0, length: text.utf16.count)
        let matches = passwordRegex.firstMatch(in: text, options: [], range: range)
        if password.trimmingCharacters(in: .whitespaces).isEmpty || matches == nil {
            passwordFieldStatus = InputFieldStatus.error
        } else {
            passwordFieldStatus = InputFieldStatus.valid
        }
    }
    
    @MainActor func validateRePassword(_ text: String) {
        if password != rePassword {
            rePasswordFieldStatus = InputFieldStatus.error
        } else {
            rePasswordFieldStatus = InputFieldStatus.valid
        }
    }
}
