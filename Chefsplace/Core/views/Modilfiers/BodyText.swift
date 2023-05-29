//
//  BodyText.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 29.05.23.
//

import SwiftUI

struct BodyText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom(
                Constants.Fonts.bodyFont,
                size: Constants.Spacing.standardPlus
            ))
    }
}
