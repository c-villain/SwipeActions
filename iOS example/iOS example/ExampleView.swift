import SwiftUI
import SwipeActions

struct Elem: Identifiable {
    let id: String
    let name: String
}

var elements: [Elem] = [
    Elem(id: "1", name: "Test"),
    Elem(id: "2", name: "Test"),
    Elem(id: "3", name: "Test")
]

struct ExampleView: View {
    
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
                            .background(Color(UIColor.systemBackground))
                            .addFullSwipeAction(menu: .slided,
                                                swipeColor: Color.red,
                                                state: $state) {
                                Leading {
                                    Button {
                                        print("check \(cell)")
                                    } label: {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .background(Color.green)
                                    
                                    Button {
                                        print("message \(cell)")
                                    } label: {
                                        Image(systemName: "message")
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
                                        Image(systemName: "archivebox")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .background(Color.gray)
                                    
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "trash")
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
                Image(systemName: "arrow.left.square.fill")
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
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 80, height: 80)
                                    .background(Color.green)
                                    
                                    Button {
                                        print("message \(cell)")
                                    } label: {
                                        Image(systemName: "message")
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
                                        Image(systemName: "archivebox")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 80, height: 80)
                                    .background(Color.gray)
                                    
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "trash")
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
                Image(systemName: "chevron.left.square.fill")
                Text("Slided")
            }

            List(elements) { e in
                Text(e.name)
                    .padding(.horizontal, 16)
                    .frame(width: UIScreen.main.bounds.size.width - 32)
                    .background(Color(UIColor.systemBackground))
                    .addSwipeAction(edge: .trailing) {
                        Button {
                            print("remove")
                        } label: {
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                        }
                        .frame(width: 60, height: 80, alignment: .center)
                        .contentShape(Rectangle())
                        .background(Color.red)
                    }
                    .listRowInsets(EdgeInsets())
                    
            }
            .padding(16)
            .listStyle(.plain)
            .tabItem {
                Image(systemName: "chevron.left.square.fill")
                Text("List")
            }
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
