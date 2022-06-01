//
//  SwipeActionModifier.swift
//  
//
//  Created by Alexander Kraev on 24.12.2021.
//

import SwiftUI

public extension View {
    
    @ViewBuilder
    func addSwipeAction<V1: View, V2: View>(menu: MenuType = .slided, isSwiped: Binding<Bool> = .constant(false), @ViewBuilder _ content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>) -> some View {
        self.modifier(SwipeAction.init(menu: menu, isSwiped: isSwiped, content))
    }
    
    @ViewBuilder
    func addSwipeAction<V1: View>(menu: MenuType = .slided, edge: HorizontalAlignment, isSwiped: Binding<Bool> = .constant(false), @ViewBuilder _ content: @escaping () -> V1) -> some View {
        switch edge {
        case .leading:
            self.modifier(SwipeAction<V1, EmptyView>.init(menu: menu, isSwiped: isSwiped, leading: content))
        default:
            self.modifier(SwipeAction<EmptyView, V1>.init(menu: menu, isSwiped: isSwiped, trailing: content))
        }
    }

    @ViewBuilder
    func addFullSwipeAction<V1: View, V2: View>(menu: MenuType = .slided,
                                                swipeColor: Color = Color.red,
                                                isSwiped: Binding<Bool> = .constant(false),
                                                @ViewBuilder _ content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>,
                                                action: (() -> Void)? = nil) -> some View {
        self.modifier(SwipeAction.init(menu: menu, allowsFullSwipe: true, swipeColor: swipeColor, isSwiped: isSwiped, content, action: action))
    }
}
