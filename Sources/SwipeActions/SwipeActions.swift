//
//  SwipeActions.swift
//
//
//  Created by Alexander Kraev on 24.12.2021.
//

import SwiftUI

public typealias Leading<V> = Group<V> where V:View
public typealias Trailing<V> = Group<V> where V:View

public struct SwipeAction<V1: View, V2: View>: ViewModifier {

    enum VisibleButton {
        case none
        case left
        case right
    }
    
    @State private var offset: CGFloat = 0
    @State private var oldOffset: CGFloat = 0
    @State private var visibleButton: VisibleButton = .none
    
    @State private var maxLeadingOffset: CGFloat = .zero
    @State private var minTrailingOffset: CGFloat = .zero
    
    private let leadingSwipeView: Group<V1>?
    private let trailingSwipeView: Group<V2>?
    
    init(@ViewBuilder _ content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>) {
        leadingSwipeView = content().value.0
        trailingSwipeView = content().value.1
    }

    init(@ViewBuilder leading: @escaping () -> V1) {
        leadingSwipeView = Group { leading() }
        trailingSwipeView = nil
    }

    init(@ViewBuilder trailing: @escaping () -> V2) {
        trailingSwipeView = Group { trailing() }
        leadingSwipeView = nil
    }
    
    func reset() {
        visibleButton = .none
        offset = 0
        oldOffset = 0
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
                .contentShape(Rectangle()) ///otherwise swipe won't work in vacant area
                .offset(x: offset)
                .gesture(DragGesture(minimumDistance: 15, coordinateSpace: .local)
                            .onChanged({ (value) in
                    let totalSlide = value.translation.width + oldOffset
                    if  (0...Int(maxLeadingOffset) ~= Int(totalSlide)) || (Int(minTrailingOffset)...0 ~= Int(totalSlide)) { //left to right slide
                        withAnimation{
                            offset = totalSlide
                        }
                    }
                    ///can update this logic to set single button action with filled single button background if scrolled more then buttons width
                })
                            .onEnded({ value in
                    withAnimation {
                        if visibleButton == .left && value.translation.width < -20 { ///user dismisses left buttons
                            reset()
                        } else if  visibleButton == .right && value.translation.width > 20 { ///user dismisses right buttons
                            reset()
                        } else if offset > 25 || offset < -25 { ///scroller more then 50% show button
                            if offset > 0 {
                                visibleButton = .left
                                offset = maxLeadingOffset
                            } else {
                                visibleButton = .right
                                offset = minTrailingOffset
                            }
                            oldOffset = offset
                            ///Bonus Handling -> set action if user swipe more then x px
                        } else {
                            reset()
                        }
                    }
                }))
            HStack(alignment: .center, spacing: 0) {
                leadingSwipeView
                    .measureSize {
                        maxLeadingOffset = maxLeadingOffset + $0.width
                    }
                    .offset(x: (-1 * maxLeadingOffset) + offset)
                Spacer()
                trailingSwipeView
                    .measureSize {
                        minTrailingOffset = (abs(minTrailingOffset) + $0.width) * -1
                    }
                    .offset(x: (-1 * minTrailingOffset) + offset)
            }
        }
    }
}
