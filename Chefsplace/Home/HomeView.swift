//
//  HomeView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import SwiftUI

struct HomeView: View {
    @State var isLoginScreenOpen = false
    
    var body: some View {
        NavigationStack {
            RegisterView()
        }
        .fullScreenCover(isPresented: $isLoginScreenOpen) {
            LoginView(isPresented: $isLoginScreenOpen)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
