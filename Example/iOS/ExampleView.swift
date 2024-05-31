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
    
    var menu: some View {
        Group {
            Button {
                print("Action 1")
            } label: {
                Text("Action 1")
            }
            
            Button {
                print("Action 2")
            } label: {
                Text("Action 2")
            }
        }
        .foregroundColor(.orange)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
    
    
    var body: some View {
        
        TabView {
            
            // Tab 1
            // Full swiped example in lazy views
            tab1
            
            // Tab 2
            // Full swiped example with destructive and non-destructive roles
            tab2
            
            // Tab 3
            // slided and swiped types demo
            tab3
            
            // Tab 4
            // Demo for lists
            tab4
            
            // Tab 5
            // Demo for custom views
            tab5
        }
    }
    
    var tab1: some View {
        VStack {
            Text("Full swiped demo in lazy views:")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            if #available(iOS 14.0, *) {
                Text("non-destructive swipe role ⬇️")
                    .font(.title)
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(0...100, id: \.self) { cell in
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
                                        .frame(width: 60)
                                        .frame(maxHeight: .infinity)
                                        .contentShape(Rectangle())
                                        .background(Color.blue)
                                    }
                                    Trailing {
                                        Button {
                                        } label: {
                                            Image(systemName: "archivebox")
                                                .foregroundColor(.white)
                                        }
                                        .frame(width: 60)
                                        .frame(maxHeight: .infinity)
                                        .contentShape(Rectangle())
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
        }
        .tabItem {
            Image(systemName: "list.triangle")
            Text("Lazy")
        }
    }
    
    var tab2: some View {
        VStack {
            Text("Full swiped example")
                .font(.largeTitle)
            
            Text("destructive swipe role ⬇️")
                .font(.title)
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(range, id: \.self) { cell in
                        Text("Cell \(cell)")
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
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
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .contentShape(Rectangle())
                                    .background(Color.green)
                                    
                                    Button {
                                        selectedAction = "message cell \(cell)"
                                        showingAlert = true
                                    } label: {
                                        Image(systemName: "message")
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .contentShape(Rectangle())
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
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .contentShape(Rectangle())
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
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .contentShape(Rectangle())
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
            
            Text("non-destructive swipe role ⬇️")
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
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .contentShape(Rectangle())
                                    .background(Color.blue)
                                }
                                Trailing {
                                    Button {
                                    } label: {
                                        Image(systemName: "archivebox")
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .contentShape(Rectangle())
                                    .background(Color.green)
                                }
                            } action: {
                                withAnimation {
                                    selectedAction = "Full swiped action!"
                                    fullSwiped = true
                                }
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
        }
        .tabItem {
            Image(systemName: "arrow.left.square.fill")
            Text("Full swipe slided")
        }
    }
    
    var tab3: some View {
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
            Image(systemName: "arrow.left.square.fill")
            Text("Slided")
        }
    }
    
    var tab4: some View {
        VStack(spacing: 32) {
            Text("Swipe actions in List")
                .font(.largeTitle)
            VStack(spacing: 16) {
                Text(".swiped ⬇️")
                    .font(.title)
                
                List(elements) { e in
                    Text(e.name)
                        .frame(width: UIScreen.main.bounds.size.width - 32, height: 80)
                        .contentShape(Rectangle())
                        .background(Color(UIColor.systemBackground))
                        .onTapGesture {
                        }
                        .addSwipeAction(menu: .swiped,
                                        state: $state) {
                            
                            Leading {
                                Button {
                                } label: {
                                    Image(systemName: "message")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 60, height: 80)
                                .contentShape(Rectangle())
                                .background(Color.blue)
                            }
                            Trailing {
                                Button {
                                } label: {
                                    Image(systemName: "archivebox")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 60, height: 80)
                                .contentShape(Rectangle())
                                .background(Color.green)
                            }
                        }
                                        .listRowInsets(EdgeInsets())
                                        .hideSeparators()
                }
                .padding(16)
                .listStyle(.plain)
            }
            
            VStack(spacing: 16) {
                Text(".slided ⬇️")
                    .font(.title)
                
                List(elements) { e in
                    Text(e.name)
                        .padding(.horizontal, 16)
                        .frame(width: UIScreen.main.bounds.size.width - 32, height: 80)
                        .background(Color(UIColor.systemBackground))
                        .onTapGesture {
                        }
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
                                        .hideSeparators()
                    
                }
                .padding(16)
                .listStyle(.plain)
            }
        }
        .tabItem {
            Image(systemName: "list.bullet")
            Text("List")
        }
    }
    
    var tab5: some View {
        VStack {
            ScrollView {
                VStack(spacing: 32) {
                    HStack {
                        Text("Leading")
                        Spacer()
                        Text("Button")
                        Spacer()
                        Text("Trailing")
                    }
                    .frame(height: 80)
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.8))
                    .addSwipeAction(edge: .trailing) {
                        Rectangle()
                            .fill(Color.green.opacity(0.8))
                            .frame(width: 8.0, height: 80)
                        
                        Button {
                        } label: {
                            Image(systemName: "message")
                                .foregroundColor(.white)
                        }
                        .frame(width: 60, height: 80)
                        .contentShape(Rectangle())
                        .background(Color.blue)
                    }
                    
                    VStack(spacing: 12) {
                        Text("SomeView")
                            .frame(height: 80)
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.8))
                        Text("Some View")
                            .frame(height: 80)
                            .frame(maxWidth: .infinity)
                            .background(Color.yellow.opacity(0.8))
                        Text("Some view")
                            .frame(height: 80)
                            .frame(maxWidth: .infinity)
                            .background(Color.black.opacity(0.3))
                    }
                    .addSwipeAction(edge: .trailing) {
                        Button {
                        } label: {
                            Image(systemName: "message")
                                .foregroundColor(.white)
                        }
                        .frame(width: 100, height: 264)
                        .contentShape(Rectangle())
                        .background(Color.blue)
                    }
                }
            }
            Text("cells with Context menu ⬇️")
                .font(.title)
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(range, id: \.self) { cell in
                        Text("Cell \(cell)")
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
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
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .contentShape(Rectangle())
                                    .background(Color.green)
                                    
                                    Button {
                                        selectedAction = "message cell \(cell)"
                                        showingAlert = true
                                    } label: {
                                        Image(systemName: "message")
                                            .foregroundColor(.white)
                                    }
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .contentShape(Rectangle())
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
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .contentShape(Rectangle())
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
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .contentShape(Rectangle())
                                    .background(Color.red)
                                }
                            } action: {
                                withAnimation {
                                    if let index = range.firstIndex(of: cell) {
                                        range.remove(at: index)
                                    }
                                }
                            }
                            .contextMenu {
                                menu
                            }
                            .listRowInsets(EdgeInsets())
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .tabItem {
            Image(systemName: "questionmark.bubble.fill")
            Text("Custom")
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}

extension View {
    @ViewBuilder
    func hideSeparators() -> some View {
        if #available(iOS 15.0, *) {
            self.listRowSeparator(.hidden)
        } else {
            self
                .onAppear {
                    
                    if #available(iOS 14.0, *) {
                        // iOS 14 doesn't have extra separators below the list by default.
                    } else {
                        // To remove only extra separators below the list:
                        UITableView.appearance().tableFooterView = UIView()
                    }
                    
                    // To remove all separators including the actual ones:
                    UITableView.appearance().separatorStyle = .none
                }
        }
    }
}
