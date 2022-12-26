import SwiftUI
import SwipeActions

struct Elem: Identifiable {
    let id: String
    let name: String
}

var elements: [Elem] = [
    Elem(id: "1", name: "Cell 1"),
    Elem(id: "2", name: "Cell 2"),
    Elem(id: "3", name: "Cell 3")
]

struct ExampleView: View {
    
    @State var state: SwipeState = .untouched
    @State private var showingAlert = false
    @State private var selectedAction: String = ""
    @State private var fullSwiped = false
    
    @State var range: [Int] = [1,2,3,4,5,6,7,8,9,10]
    var body: some View {
        TabView {
            
            // Tab 1
            VStack {
                Text("Full swiped example")
                    .font(.largeTitle)
                
                Text("destructive full swipe role")
                    .font(.title)
                
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(range, id: \.self) { cell in
                            Text("Cell \(cell)")
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(UIColor.systemBackground))
                                .addFullSwipeAction(menu: .slided,
                                                    swipeColor: .red,
                                                    state: $state) {
                                    Leading {
                                        Button {
                                            selectedAction = "cell \(cell) checked!"
                                            showingAlert = true
                                        } label: {
                                            Image(systemName: "checkmark.circle")
                                                .foregroundColor(.white)
                                        }
                                        .contentShape(Rectangle())
                                        .frame(width: 60)
                                        .frame(maxHeight: .infinity)
                                        .background(Color.green)
                                        
                                        Button {
                                            selectedAction = "message cell \(cell)"
                                            showingAlert = true
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
                                            selectedAction = "cell \(cell) archived!"
                                            showingAlert = true
                                        } label: {
                                            Image(systemName: "archivebox")
                                                .foregroundColor(.white)
                                        }
                                        .contentShape(Rectangle())
                                        .frame(width: 60)
                                        .frame(maxHeight: .infinity)
                                        .background(Color.gray)
                                        
                                        Button {
                                            withAnimation {
                                                if let index = range.firstIndex(of: cell) {
                                                    range.remove(at: index)
                                                }
                                            }
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
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(selectedAction), dismissButton: .cancel())
                }
                
                Text("Non-destructive full swipe role")
                    .font(.title)
                ScrollView {
                    VStack(spacing: 0) {
                        ForEach(0...10, id: \.self) { cell in
                            Text("Cell \(cell)")
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(UIColor.systemBackground))
                                .addFullSwipeAction(menu: .slided,
                                                    swipeColor: .green,
                                                    swipeRole: .defaults,
                                                    state: $state) {
                                    Leading {
                                        Button {
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
                                        } label: {
                                            Image(systemName: "archivebox")
                                                .foregroundColor(.white)
                                        }
                                        .contentShape(Rectangle())
                                        .frame(width: 60)
                                        .frame(maxHeight: .infinity)
                                        .background(Color.green)
                                    }
                                } action: {
                                    withAnimation {
                                        selectedAction = "Full swiped action!"
                                        fullSwiped = true
                                    }
                                }
                                .listRowInsets(EdgeInsets())
                        }
                    }
                }
                .alert(isPresented: $fullSwiped) {
                    Alert(title: Text(selectedAction),
                          dismissButton: .default(Text("Archived!")) {
                        withAnimation {
                            state = .swiped(UUID())
                        }
                    })
                }
            }
            .tabItem {
                Image(systemName: "arrow.left.square.fill")
                Text("Full swipe slided")
            }
            
            // Tab 2
            VStack {
                Text("Swipe actions")
                    .font(.largeTitle)
                
                Text(".swiped ⬇️")
                    .font(.title)
                
                ScrollView {
                    VStack(spacing: 2) {
                        ForEach(1 ... 30, id: \.self) { cell in
                            Text("Cell \(cell)")
                                .padding()
                                .frame(height: 80)
                                .frame(maxWidth: .infinity)
                                .background(
                                    ZStack {
                                        Color(UIColor.systemBackground)
                                        Color.green.opacity(0.2)
                                    }
                                )
                                .contentShape(Rectangle())
                                .listStyle(.plain)
                                .addSwipeAction(menu: .swiped,
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
                
                Text(".slided ⬇️")
                    .font(.title)
                
                ScrollView {
                    VStack(spacing: 2) {
                        ForEach(1 ... 30, id: \.self) { cell in
                            Text("Cell \(cell)")
                                .padding()
                                .frame(height: 80)
                                .frame(maxWidth: .infinity)
                                .contentShape(Rectangle())
                                .listStyle(.plain)
                                .background(Color.yellow.opacity(0.2))
                                .addSwipeAction(state: $state) {
                                    Leading {
                                        Button {
                                            print("check \(cell)")
                                        } label: {
                                            Image(systemName: "checkmark.circle")
                                                .foregroundColor(.white)
                                        }
                                        .frame(width: 80, height: 80)
                                        .contentShape(Rectangle())
                                        .background(Color.green)
                                        
                                        Button {
                                            print("message \(cell)")
                                        } label: {
                                            Image(systemName: "message")
                                                .foregroundColor(.white)
                                        }
                                        .frame(width: 80, height: 80)
                                        .contentShape(Rectangle())
                                        .background(Color.blue)
                                    }
                                    Trailing {
                                        Button {
                                            print("archive \(cell)")
                                        } label: {
                                            Image(systemName: "archivebox")
                                                .foregroundColor(.white)
                                        }
                                        .frame(width: 80, height: 80)
                                        .contentShape(Rectangle())
                                        .background(Color.gray)
                                        
                                        Button {
                                            print("remove \(cell)")
                                        } label: {
                                            Image(systemName: "trash")
                                                .foregroundColor(.white)
                                        }
                                        .frame(width: 80, height: 80)
                                        .contentShape(Rectangle())
                                        .background(Color.red)
                                    }
                                }
                        }
                    }
                }
            }
            .tabItem {
                Image(systemName: "chevron.left.square.fill")
                Text("Slided")
            }
            
            VStack(spacing: 32) {
                Text("Swipe actions in List")
                    .font(.largeTitle)
                VStack(spacing: 16) {
                    Text(".swiped ⬇️")
                        .font(.title)
                    
                    List(elements) { e in
                        Text(e.name)
                            .frame(width: UIScreen.main.bounds.size.width - 32, height: 80)
                            .background(Color(UIColor.systemBackground))
                            .onTapGesture {
                                print("on cell tap!")
                            }
                            .addSwipeAction(menu: .swiped,
                                            edge: .trailing,
                                            state: $state) {
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
                }
                
                VStack(spacing: 16) {
                    Text(".slided ⬇️")
                        .font(.title)
                    
                    List(elements) { e in
                        Text(e.name)
                            .padding(.horizontal, 16)
                            .frame(width: UIScreen.main.bounds.size.width - 32, height: 80)
                            .background(Color(UIColor.systemBackground))
                            .addSwipeAction(edge: .trailing,
                                            state: $state) {
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
                }
            }
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
