//
//  InputFields.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 29.05.23.
//

import SwiftUI

enum InputFieldStatus {
    case clear
    case error
    case valid
}

struct InputFieldWhithBg: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String
    let placeHolderColor: Color = Constants.Colors.charcoal
    let bgColor: Color = Constants.Colors.terciary
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: Constants.Spacing.standard)
                .fill(bgColor)
                .frame(width: Constants.Spacing.maxFormFieldWidth, height: Constants.Spacing.formFieldHeigh)
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundColor(placeHolderColor)
                    .padding(.horizontal, 15)
            }
            content
                .padding()
                .foregroundColor(placeHolderColor)
                .frame(width: Constants.Spacing.maxFormFieldWidth, height: Constants.Spacing.formFieldHeigh)
        }
    }
}
