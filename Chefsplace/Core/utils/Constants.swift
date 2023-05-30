//
//  Constants.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 19.05.23.
//

import Foundation
import SwiftUI

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
        public static let textColor = Color("text")
        public static let primary = Color("primary")
        public static let secondary = Color("secondary")
        public static let terciary = Color("terciary")
        public static let quarternary = Color("quarternary")
        public static let orange = Color("orange")
        public static let error = Color("error")
        public static let charcoal = Color("charcoal")
    }
    
    enum Spacing {
        public static let xxsmall = CGFloat(2.0)
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
        
        public static let formFieldHeigh = CGFloat(50.0)
        public static let maxFormFieldWidth = CGFloat(300.0)
    }
    
    enum Images {
        public static let loginBg = "login-bg"
        public static let registerBg = "register-bg"
    }
    
    enum IconNames {
        public static let visiblePasswordIcon = "eye.slash"
        public static let notVisiblePasswordIcon = "eye"
        public static let login = "arrow.right.square"
        public static let register = "square.and.pencil"
    }
    
    enum Fonts {
        public static let headingFont = "PT Sans"
        public static let bodyFont = "Lato"
    }
}
