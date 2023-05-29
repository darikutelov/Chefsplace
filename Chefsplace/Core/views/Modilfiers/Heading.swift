//
//  Heading.swift
//  Chefsplace
//
//  Created by Dariy Kutelov on 29.05.23.
//

import SwiftUI

struct Heading: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom(
                Constants.Fonts.headingFont,
                size: Constants.Spacing.large
            ))
            .fontWeight(.bold)
            .kerning(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
    }
}
