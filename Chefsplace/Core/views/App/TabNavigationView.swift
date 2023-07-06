//
//  TabNavigationView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 23.05.23.
//

import SwiftUI

struct TabNavigationView: View {
    @AppStorage(Constants.TabIcons.userdefaultsKey) var selectedTab = 0
    var mainViewModel: MainViewViewModel
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Image(systemName: Constants.TabIcons.homeIcon)
                        Text(String(localized: "home_label"))
                    }
                    .tag(0)
                ProductsView()
                    .tabItem {
                        Image(systemName: Constants.TabIcons.searchIcon)
                        Text(String(localized: "products_label"))
                    }
                    .tag(1)
                WishlistView()
                    .tabItem {
                        Image(systemName: Constants.TabIcons.wishlistIcon)
                        Text(String(localized: "wishlist_label"))
                    }
                    .tag(2)
                CartView()
                    .tabItem {
                        Image(systemName: Constants.TabIcons.cartIcon)
                        Text(String(localized: "cart_label"))
                    }
                    .tag(3)
                    .badge(2)
                if mainViewModel.currentUserId.isEmpty {
                    ProfileView()
                        .tabItem {
                            Image(systemName: Constants.TabIcons.profileIcon)
                            Text(String(localized: "profile_label"))
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
