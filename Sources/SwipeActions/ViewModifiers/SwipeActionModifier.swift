//
//  SwipeActionModifier.swift
//  
//
//  Created by Alexander Kraev on 24.12.2021.
//

import SwiftUI

public extension View {
    
    @ViewBuilder
    func addSwipeAction<V1: View, V2: View>(@ViewBuilder _ content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>) -> some View {
        self.modifier(SwipeAction.init(content))
    }
    
    @ViewBuilder
    func addSwipeAction<V1: View>(edge: HorizontalAlignment, @ViewBuilder _ content: @escaping () -> V1) -> some View {
        switch edge {
        case .leading:
            self.modifier(SwipeAction<V1, EmptyView>.init(leading: content))
        default:
            self.modifier(SwipeAction<EmptyView, V1>.init(trailing: content))
        }
    }
}
