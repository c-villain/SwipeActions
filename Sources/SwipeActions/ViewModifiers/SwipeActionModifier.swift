import SwiftUI

public extension View {
    
    @ViewBuilder
    func addSwipeAction<V1: View, V2: View>(
        menu: MenuType = .slided,
        state: Binding<SwipeState> = .constant(.untouched),
        @ViewBuilder _ content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>
    ) -> some View {
        self.modifier(
            SwipeAction.init(
                menu: menu,
                state: state,
                content
            )
        )
    }
    
    @ViewBuilder
    func addSwipeAction<V1: View>(
        menu: MenuType = .slided,
        edge: HorizontalAlignment,
        state: Binding<SwipeState> = .constant(.untouched),
        @ViewBuilder _ content: @escaping () -> V1
    ) -> some View {
        switch edge {
        case .leading:
            self.modifier(
                SwipeAction<V1, EmptyView>.init(
                    menu: menu,
                    state: state,
                    leading: content
                )
            )
        default:
            self.modifier(
                SwipeAction<EmptyView, V1>.init(
                    menu: menu,
                    state: state,
                    trailing: content
                )
            )
        }
    }

    @ViewBuilder
    func addFullSwipeAction<V1: View, V2: View>(
        menu: MenuType = .slided,
        swipeColor: Color = Color.red,
        swipeRole: SwipeRole = .destructive,
        state: Binding<SwipeState> = .constant(.untouched),
        @ViewBuilder _ content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>,
        action: (() -> Void)? = nil
    ) -> some View {
        self.modifier(
            SwipeAction.init(
                menu: menu,
                allowsFullSwipe: true,
                fullSwipeRole: swipeRole,
                swipeColor: swipeColor,
                state: state,
                content,
                action: action
            )
        )
    }
}
