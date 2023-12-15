//
//  View+If.swift
//  Recipes
//
//  Created by Zach Barton on 12/14/23.
//

import Foundation
import View

extension View {
    @ViewBuilder func `if`<Content: View>(
        _ condition: Bool,
        transform: (Self) -> Content
    ) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
