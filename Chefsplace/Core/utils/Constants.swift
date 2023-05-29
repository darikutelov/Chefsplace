//
//  Constants.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 19.05.23.
//

import Foundation

enum Constants {
    enum General {}
    
    enum TabIcons {
        public static let userdefaultsKey = "HomeScreenCurrentTab"
        public static let homeIcon = "house"
        public static let searchIcon = "magnifyingglass"
        public static let wishlistIcon = "heart.fill"
        public static let cartIcon = "cart"
        public static let profileIcon = "person"
    }
    
    enum Api {
        // public static let host = "dry-chamber-19090.herokuapp.com"
        public static let host = "localhost"
    }
    
    enum Colors {
        public static let textColor = "text"
        public static let primary = "primary"
        public static let secondary = "secondary"
        public static let terciary = "terciary"
        public static let quarternary = "quarternary"
        public static let orange = "orange"
        public static let error = "error"
    }
    
    enum Spacing {
        public static let xsmall = CGFloat(4.0)
        public static let small = CGFloat(8.0)
        public static let standard = CGFloat(12.0)
        public static let standardPlus = CGFloat(16.0)
        public static let medium = CGFloat(20.0)
        public static let mediumPlus = CGFloat(24.0)
        public static let large = CGFloat(28.0)
        public static let xlarge = CGFloat(32.0)
        public static let xxlarge = CGFloat(36.0)
        public static let xxxlarge = CGFloat(48.0)
        public static let superLarge = CGFloat(64.0)
        public static let megaLarge = CGFloat(92.0)
        public static let extraLarge = CGFloat(156.0)
        public static let maxWidth = CGFloat(400.0)
    }
    
    enum Images {
        public static let loginBg = "login-bg"
    }
}
