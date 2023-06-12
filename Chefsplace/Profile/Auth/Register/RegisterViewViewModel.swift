//
//  RegisterViewViewModel.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import SwiftUI
import Foundation
import FirebaseAuth

final class RegisterViewViewModel: AuthViewModel, ObservableObject {
    @Published var rePassword = "" {
        willSet {
            Task {
                await validateRePassword(rePassword)
            }
        }
    }
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
            let authDataResult = try await Auth
                .auth()
                .createUser(
                    withEmail: email,
                    password: password
                )
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
        
        guard emailFieldStatus == .valid && !email.isEmpty else {
            errorMessage = String(localized: "error_valid_email")
            return false
        }
        
        guard passwordFieldStatus == .valid && !password.isEmpty else {
            errorMessage = String(localized: "error_valid_password")
            return false
        }
        
        guard rePasswordFieldStatus == .valid && !rePassword.isEmpty else {
            errorMessage = String(localized: "error_valid_rePassword")
            return false
        }
        
        return true
    }
    
    @MainActor func validateRePassword(_ text: String) {
        if password != rePassword {
            rePasswordFieldStatus = InputFieldStatus.error
        } else {
            rePasswordFieldStatus = InputFieldStatus.valid
        }
    }
}
