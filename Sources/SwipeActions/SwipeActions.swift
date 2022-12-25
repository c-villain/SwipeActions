import SwiftUI

public typealias Leading<V> = Group<V> where V:View
public typealias Trailing<V> = Group<V> where V:View

public enum MenuType {
    case slided /// hstacked
    case swiped /// zstacked
}

/// Full swipe main role:
public enum SwipeRole {
    case destructive /// for removing element
    case cancel
    case defaults
}

/// For opened cells auto-hiding during swiping anothers
public enum SwipeState: Equatable {
    case untouched
    case swiped(UUID)
}

struct SwipeAction<V1: View, V2: View>: ViewModifier {

    enum VisibleButton {
        case none
        case left
        case right
    }

    @Binding private var state: SwipeState
    @State private var offset: CGFloat = 0
    @State private var oldOffset: CGFloat = 0
    @State private var visibleButton: VisibleButton = .none
    
    /**
     To detect if drag gesture is ended because of known issue that drag gesture onEnded not called:
     https://stackoverflow.com/questions/58807357/detect-draggesture-cancelation-in-swiftui
     */
    @GestureState private var dragGestureActive: Bool = false
    
    @State private var maxLeadingOffset: CGFloat = .zero
    @State private var minTrailingOffset: CGFloat = .zero
    
    @State private var contentWidth: CGFloat = .zero
    @State private var isDeletedRow: Bool = false
    /**
     For lazy views: because of measuring size occurred every onAppear
     */
    @State private var maxLeadingOffsetIsCounted: Bool = false
    @State private var minTrailingOffsetIsCounted: Bool = false
    
    private let menuTyped: MenuType
    private let leadingSwipeView: Group<V1>?
    private let trailingSwipeView: Group<V2>?

    private let swipeColor: Color?
    private let allowsFullSwipe: Bool
    private let fullSwipeRole: SwipeRole
    private let action: (() -> Void)?
    private let id: UUID = UUID()
    
    init(menu: MenuType,
         allowsFullSwipe: Bool = false,
         fullSwipeRole: SwipeRole = .defaults,
         swipeColor: Color? = nil,
         state: Binding<SwipeState>,
         @ViewBuilder _ content: @escaping () -> TupleView<(Leading<V1>, Trailing<V2>)>,
         action: (() -> Void)? = nil) {
        menuTyped = menu
        self.allowsFullSwipe = allowsFullSwipe
        self.fullSwipeRole = fullSwipeRole
        self.swipeColor = swipeColor
        _state = state
        leadingSwipeView = content().value.0
        trailingSwipeView = content().value.1
        self.action = action
    }

    init(menu: MenuType,
         allowsFullSwipe: Bool = false,
         fullSwipeRole: SwipeRole = .defaults,
         swipeColor: Color? = nil,
         state: Binding<SwipeState>,
         @ViewBuilder leading: @escaping () -> V1,
         action: (() -> Void)? = nil) {
        menuTyped = menu
        self.allowsFullSwipe = allowsFullSwipe
        self.fullSwipeRole = fullSwipeRole
        self.swipeColor = swipeColor
        _state = state
        leadingSwipeView = Group { leading() }
        trailingSwipeView = nil
        self.action = action
    }
    
    init(menu: MenuType,
         allowsFullSwipe: Bool = false,
         fullSwipeRole: SwipeRole = .defaults,
         swipeColor: Color? = nil,
         state: Binding<SwipeState>,
         @ViewBuilder trailing: @escaping () -> V2,
         action: (() -> Void)? = nil) {
        menuTyped = menu
        self.allowsFullSwipe = allowsFullSwipe
        self.fullSwipeRole = fullSwipeRole
        self.swipeColor = swipeColor
        _state = state
        trailingSwipeView = Group { trailing() }
        leadingSwipeView = nil
        self.action = action
    }
    
    func reset() {
        visibleButton = .none
        offset = 0
        oldOffset = 0
    }
    
    var leadingView: some View {
        leadingSwipeView
            .measureSize {
                if !maxLeadingOffsetIsCounted {
                    maxLeadingOffset = maxLeadingOffset + $0.width
                }
            }
            .onAppear {
                /**
                 maxLeadingOffsetIsCounted for of lazy views
                 */
                if #available(iOS 15, *) {
                    maxLeadingOffsetIsCounted = true
                }
            }
    }

    var trailingView: some View {
        trailingSwipeView
            .measureSize {
                if !minTrailingOffsetIsCounted {
                    minTrailingOffset = (abs(minTrailingOffset) + $0.width) * -1
                }
            }
            .onAppear {
                /**
                 maxLeadingOffsetIsCounted for of lazy views
                 */
                if #available(iOS 15, *) {
                    minTrailingOffsetIsCounted = true
                }
            }
    }
    
    var swipedMenu: some View {
        HStack(spacing: 0) {
            leadingView
            Spacer()
            trailingView
                .offset(x: allowsFullSwipe && offset < minTrailingOffset ? (-1 * minTrailingOffset) + offset : 0)
        }
    }
    
    var slidedMenu: some View {
        HStack(spacing: 0) {
            leadingView
                .offset(x: (-1 * maxLeadingOffset) + offset)
            Spacer()
            trailingView
                .offset(x: (-1 * minTrailingOffset) + offset)
        }
    }
    
    func gesturedContent(content: Content) -> some View {
        
        content
            .tag(id)
            .contentShape(Rectangle()) ///otherwise swipe won't work in vacant area
            .offset(x: offset)
            .measureSize {
                contentWidth = $0.width
            }
            .gesture(
                DragGesture(minimumDistance: 15, coordinateSpace: .local)
                    .updating($dragGestureActive) { value, state, transaction in
                        state = true
                    }
                    .onChanged { value in
                        let totalSlide = value.translation.width + oldOffset
                        
                        if allowsFullSwipe && ...0 ~= Int(totalSlide) {
                            withAnimation {
                                offset = totalSlide
                            }
                        } else if (0 ... Int(maxLeadingOffset) ~= Int(totalSlide)) || (Int(minTrailingOffset) ... 0 ~= Int(totalSlide)) {
                            withAnimation {
                                offset = totalSlide
                            }
                        }
                    }.onEnded { value in
                        withAnimation {
                            if visibleButton == .left,
                               value.translation.width < -20 { ///user dismisses left buttons
                                reset()
                            } else if visibleButton == .right,
                                      value.translation.width > 20 { ///user dismisses right buttons
                                reset()
                            } else if offset >  25 || offset < -25 { ///scroller more then 50% show button
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
                        
                        if allowsFullSwipe,
                            value.translation.width < -(contentWidth * 0.7) {
                            withAnimation(.linear(duration: 0.3)) {
                                offset = -contentWidth
                            }
                            
                            switch fullSwipeRole {
                            case .destructive:
                                withAnimation(.linear(duration: 0.3)) {
                                    isDeletedRow = true
                                }
                            case .cancel:
                                withAnimation {
                                    reset()
                                }
                            default:
                                break
                            }
                            
                            action?()
                        }
                    })
            .valueChanged(of: dragGestureActive) { dragActive in
                if !dragActive,
                   visibleButton == .none {
                    withAnimation {
                        reset()
                    }
                }
                state = dragActive ? .swiped(id) : .untouched
            }
            .valueChanged(of: state) { value in
                switch value {
                case .swiped(let tag):
                    if id != tag,
                       visibleButton != .none {
                        withAnimation(.linear(duration: 0.3)) {
                            reset()
                        }
                        state = .untouched
                    }
                default:
                    break
                }
            }
    }
    
    public func body(content: Content) -> some View {
        switch menuTyped {
        case .slided:
            ZStack {
                swipeColor
                slidedMenu
                gesturedContent(content: content)
            }
            .frame(height: isDeletedRow ? 0 : nil, alignment: .top)
        case .swiped:
            ZStack {
                swipeColor
                swipedMenu
                gesturedContent(content: content)
            }
           .frame(height: isDeletedRow ? 0 : nil, alignment: .top)
        }
    }
}
