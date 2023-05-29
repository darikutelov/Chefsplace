//
//  HomeView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import SwiftUI

struct HomeView: View {
    @State var isLoginScreenOpen = true
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Утре отивам на разходка")
                    .font(Font.custom("Lato", size: 24))
                Text("Утре отивам на разходка")
                    .font(Font.custom("PT Sans", size: 24))
                Text("Утре отивам на разходка")
                    .font(.title)
                Text("Let's go for a walk")
                    .font(Font.custom("Lato", size: 24))
                Text("Let's go for a walk")
                    .font(Font.custom("PT Sans", size: 24))
                Text("Let's go for a walk")
                    .font(.title)
            }
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
