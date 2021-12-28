//
//  SwipeActionModifier.swift
//  
//
//  Created by Alexander Kraev on 24.12.2021.
//

import SwiftUI

public extension View {
    
    @ViewBuilder
    func addSwipeAction<V1: View, V2: View>(menu: MenuType = .slided, @ViewBuilder _ content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>) -> some View {
        self.modifier(SwipeAction.init(menu: menu, content))
    }
    
    @ViewBuilder
    func addSwipeAction<V1: View>(menu: MenuType = .slided, edge: HorizontalEdge, @ViewBuilder _ content: @escaping () -> V1) -> some View {
        switch edge {
        case .leading:
            self.modifier(SwipeAction<V1, EmptyView>.init(menu: menu, leading: content))
        default:
            self.modifier(SwipeAction<EmptyView, V1>.init(menu: menu, trailing: content))
        }
    }
}
