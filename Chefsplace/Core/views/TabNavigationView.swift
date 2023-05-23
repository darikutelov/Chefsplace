//
//  TabNavigationView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import SwiftUI

struct TabNavigationView: View {
    @AppStorage(Constants.Text.TabView.userdefaultsKey) var selectedTab = 0
    var mainViewModel: MainViewViewModel
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: Constants.Text.TabView.homeIcon)
                        Text(Constants.Text.TabView.homeLabel)
                    }
                    .tag(0)
                ProductsView()
                    .tabItem {
                        Image(systemName: Constants.Text.TabView.searchIcon)
                        Text(Constants.Text.TabView.searchLabel)
                    }
                    .tag(1)
                WishlistView()
                    .tabItem {
                        Image(systemName: Constants.Text.TabView.addNFTIcon)
                        Text(Constants.Text.TabView.addNFTLabel)
                    }
                    .tag(2)
                CartView()
                    .tabItem {
                        Image(systemName: Constants.Text.TabView.cartIcon)
                        Text(Constants.Text.TabView.cartLabel)
                    }
                    .tag(3)
                    .badge(2)
                if mainViewModel.currentUserId.isEmpty {
                    ProfileView()
                        .tabItem {
                            Image(systemName: Constants.Text.TabView.profileIcon)
                            Text(Constants.Text.TabView.profileLabel)
                        }
                        .tag(4)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TabNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TabNavigationView(mainViewModel: MainViewViewModel())
    }
}
