//
//  MainViewViewModel.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import Foundation
import FirebaseAuth

protocol MainViewViewModelProtocol {
    var currentUserId: String { get }
    var isSignedIn: Bool { get }
}

final class MainViewViewModel: ObservableObject, MainViewViewModelProtocol {
    @MainActor @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            
            Task {
                await MainActor.run {
                    self.currentUserId = user?.uid ?? ""
                }
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
