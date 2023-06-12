//
//  LoginViewViewModel.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import Foundation
import SwiftUI
import FirebaseAuth

final class LoginViewViewModel: AuthViewModel, ObservableObject {

    func login() async {
        guard validate() else {
            return
        }
        do {
            let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
            let user = authDataResult.user
            
            print(user.uid)
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
    
    private func validate() -> Bool {
//        errorMessage = ""
//
//        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
//                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
//            errorMessage = "Please, fill in all fields"
//            return false
//        }
//
//        guard email.contains("@") && email.contains(".") else {
//            errorMessage = "Please, enter valid email"
//            return false
//        }
        
        return true
    }
}
