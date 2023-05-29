//
//  ButtonViews.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 29.05.23.
//

import SwiftUI

struct CustomButton: View {
    let buttonText: String
    var buttonTextColor: Color = .white
    var buttonBackgroundColor: Color = Constants.Colors.orange
    var iconName: String
    var buttonWidth: CGFloat = .infinity
    
    var body: some View {
        HStack(alignment: .center) {
            if !iconName.isEmpty {
                Image(systemName: iconName)
            }
            
            Text(buttonText.capitalized)
                .fontWeight(.semibold)
        }
        .foregroundColor(buttonTextColor.opacity(0.9))
        .font(.body)
        .padding(
            EdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
        )
        .frame(maxWidth: buttonWidth)
        .background(
            RoundedRectangle(cornerRadius: 12.0)
                .fill(buttonBackgroundColor)
        )
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(buttonText: "Sign In", iconName: "heart", buttonWidth: 300.0)
    }
}
