import SwiftUI
import SwipeActions

struct ContentView: View {
    
    @State var state: SwipeState = .untouched

    @State var range: [Int] = [1,2,3,4,5,6,7,8,9,10]
    var body: some View {
        TabView {
            
            // Tab 1
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(range, id: \.self) { cell in
                        Text("Cell \(cell)")
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(NSColor.controlBackgroundColor))
                            .addFullSwipeAction(menu: .slided,
                                                swipeColor: Color.red,
                                                state: $state) {
                                Leading {
                                    Button {
                                        print("check \(cell)")
                                    } label: {
                                        Image("􀁢")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .background(Color.green)
                                    
                                    Button {
                                        print("message \(cell)")
                                    } label: {
                                        Image("􀌤")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .background(Color.blue)
                                }
                                Trailing {
                                    Button {
                                        print("archive \(cell)")
                                    } label: {
                                        Image("􀈭")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .background(Color.gray)
                                    
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image("􀈑")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .background(Color.red)
                                }
                            } action: {
                                withAnimation {
                                    if let index = range.firstIndex(of: cell) {
                                        range.remove(at: index)
                                    }
                                }
                            }
                            .listRowInsets(EdgeInsets())
                    }
                }
            }
            .tabItem {
                Text("Full swipe slided")
            }

            // Tab 2
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(1 ... 30, id: \.self) { cell in
                        Text("Cell \(cell)")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .frame(height: 80)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                            .listStyle(.plain)
                            .addSwipeAction(menu: .slided,
                                            state: $state) {
                                Leading {
                                    Button {
                                        print("check \(cell)")
                                    } label: {
                                        Image("􀁢")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 80, height: 80)
                                    .background(Color.green)
                                    
                                    Button {
                                        print("message \(cell)")
                                    } label: {
                                        Image("􀌤")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 80, height: 80)
                                    .background(Color.blue)
                                }
                                Trailing {
                                    Button {
                                        print("archive \(cell)")
                                    } label: {
                                        Image("􀈭")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 80, height: 80)
                                    .background(Color.gray)
                                    
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image("􀈑")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 80, height: 80)
                                    .background(Color.red)
                                }
                            }
                    }
                }
            }
            .tabItem {
                Text("Slided")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
