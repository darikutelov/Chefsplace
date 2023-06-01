//
//  InputFields.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 29.05.23.
//

import SwiftUI

struct InputFieldWhithBg: ViewModifier {
    var error: Bool
    var showPlaceHolder: Bool
    var placeholder: String
    let placeHolderColor: Color = Constants.Colors.charcoal
    let bgColor: Color = Constants.Colors.terciary
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content
                .padding()
                .foregroundColor(placeHolderColor)
                .background(
                    RoundedRectangle(cornerRadius: Constants.Spacing.standard)
                        .fill(bgColor)
                )
                .frame(height: Constants.Spacing.formFieldHeigh)
                .overlay(
                    RoundedRectangle(cornerRadius: Constants.Spacing.standard)
                        .stroke(error ? Constants.Colors.error : Color(.clear),
                                lineWidth: Constants.Spacing.xxsmall)
                )
                .frame(maxWidth: Constants.Spacing.maxFormFieldWidth)
            if showPlaceHolder {
                Text(placeholder)
                    .foregroundColor(placeHolderColor)
                    .padding(.horizontal, 15)
            }
        }
    }
}
