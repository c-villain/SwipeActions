import SwiftUI

public extension View {
    @ViewBuilder
    func swipeHint(_ isActive: Bool = false, hintOffset: CGFloat, delayIn: CGFloat = 0.5, delayOut: CGFloat = 1.5) -> some View {
        if isActive {
            modifier(
                SwipeHintModifier(
                    hintOffset: hintOffset,
                    delayIn: delayIn,
                    delayOut: delayOut
                )
            )
        } else {
            self
        }
    }
}

public struct SwipeHintModifier: ViewModifier {
    let hintOffset: CGFloat
    let delayIn: CGFloat
    let delayOut: CGFloat
    @State private var offset: CGFloat = 0
    
    public func body(content: Content) -> some View {
        content
            .offset(x: -offset)
            .onAppear {
                    withAnimation(.easeInOut.delay(delayIn)) {
                        offset = hintOffset
                    }
                    withAnimation(.easeInOut.delay(delayOut)) {
                        offset = 0
                    }
            }
    }
}
