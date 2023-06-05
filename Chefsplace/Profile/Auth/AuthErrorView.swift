//
//  AuthErrorView.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 1.06.23.
//

import SwiftUI

struct AuthErrorView: View {
    let title: String = String(localized: "error")
    let iconName: String = "exclamationmark.triangle"
    let message: String
    
    var body: some View {
        VStack(spacing: Constants.Spacing.standard) {
            Image(systemName: iconName)
                    .font(.system(size: Constants.Spacing.large))
            Text(title + "! " + message)
                .multilineTextAlignment(.center)
        }
        .foregroundColor(Constants.Colors.error)
        .padding()
        .frame(width: 350)
        .background(Constants.Colors.terciary)
        .cornerRadius(Constants.Spacing.standardPlus)
        .shadow(radius: 10, x: 5, y: 5)
        .transition(.scale)
    }
}

struct AuthErrorView_Previews: PreviewProvider {
    static var previews: some View {
        AuthErrorView(message: "Your password is not valid!")
    }
}
