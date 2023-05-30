//
//  InputFields.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 29.05.23.
//

import SwiftUI

struct InputFieldWhithBg: ViewModifier {
    var error: Bool
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: Constants.Spacing.standard)
                    .fill(Constants.Colors.terciary)
            )
            .foregroundColor(Constants.Colors.primary)
            .frame(height: Constants.Spacing.formFieldHeigh)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.Spacing.standard)
                    .stroke(error ? Constants.Colors.error : Color(.clear),
                            lineWidth: Constants.Spacing.xxsmall)
            )
            .frame(maxWidth: Constants.Spacing.maxFormFieldWidth)
    }
}