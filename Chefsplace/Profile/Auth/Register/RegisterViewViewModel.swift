//
//  RegisterViewViewModel.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import Foundation

import FirebaseAuth

final class RegisterViewViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var rePassword = ""
    @Published var errorMessage = ""
    @Published var isLoading = false
    
    func register() {
        guard validate() else {
            return
        }
        
        
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
            guard error == nil else {
                self?.errorMessage = error?.localizedDescription ?? ""
                return
            }
            
            guard let userId = result?.user.uid else {
                self?.errorMessage = "Something went wrong!"
                return
            }
            
            self?.insertUserRecord(id: userId)
        }
    }
    
    
    private func insertUserRecord(id: String) {
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
    
    
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please, fill in all fields"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please, enter valid email"
            return false
        }
        
        return true
    }
}
