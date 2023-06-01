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
    @MainActor @Published var errorMessage = ""
    @MainActor @Published var isLoading = false
    
    func register() async {
        guard await validate() else {
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
                isLoading =  true
            }
            await MainActor.run {
                errorMessage = error.localizedDescription
                print(errorMessage)
            }
        }
        //        Auth.auth().createUser(withEmail: email, password: password) {[weak self] result, error in
        //            guard error == nil else {
        //                self?.errorMessage = error?.localizedDescription ?? ""
        //                return
        //            }
        //
        //            guard let userId = result?.user.uid else {
        //                self?.errorMessage = "Something went wrong!"
        //                return
        //            }
        //
        //            await self?.insertUserRecord(id: userId)
        //
        //            self?.isLoading = false
        //        }
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
