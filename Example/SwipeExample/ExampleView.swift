//
//  ExampleView.swift
//  SwipeExample
//
//  Created by aromanov on 29.04.2022.
//

import SwiftUI
import SwipeActions

struct ExampleView: View {
    
    @State var isSwiped: Bool = false
    @StateObject var viewModel = ExampleViewModel()
    
    var body: some View {
        TabView {
            
            // Tab 1
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(1 ... 100, id: \.self) { cell in
                        Text("Cell \(cell)")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .addFullSwipeAction(menu: .slided, swipeColor: Color.red, isSwiped: $isSwiped) {
                                Leading {
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60)
                                    .frame(maxHeight: .infinity)
                                    .background(Color.green)
                                    
                                    Button {
                                        print("remove \(cell)")
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
                                        print("remove \(cell)")
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
                                print(print("remove \(cell)"))
                            }
                            .listRowInsets(EdgeInsets())
                    }
                }
            }
            .tabItem {
                Label("Slided", systemImage: "rectangle.lefthalf.inset.filled.arrow.left")
            }
            
            // Tab 2
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(1 ... 100, id: \.self) { cell in
                        Text("Cell \(cell)")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                            .background(Color.white)
                            .addFullSwipeAction(menu: .swiped, swipeColor: Color.red, isSwiped: $isSwiped) {
                                Leading {
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60, height: 60)
                                    .background(Color.green)
                                    
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "message")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue)
                                }
                                Trailing {
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "archivebox")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60, height: 60)
                                    .background(Color.gray)
                                    
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60, height: 60)
                                    .background(Color.red)
                                }
                            } action: {
                                print(print("remove \(cell)"))
                            }
                    }
                }
            }
            .tabItem {
                Label("Swiped", systemImage: "rectangle.lefthalf.inset.filled.arrow.left")
            }
            
            // Tab 3
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(1 ... 100, id: \.self) { cell in
                        Text("Cell \(cell)")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                            .background(Color.white)
                            .addSwipeAction(menu: .slided, isSwiped: $isSwiped) {
                                Leading {
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60, height: 60)
                                    .background(Color.green)
                                    
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "message")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue)
                                }
                                Trailing {
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "archivebox")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60, height: 60)
                                    .background(Color.gray)
                                    
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60, height: 60)
                                    .background(Color.red)
                                }
                            }
                    }
                }
            }
            .tabItem {
                Label("Slided", systemImage: "rectangle.leadinghalf.inset.filled")
            }
            
            // Tab 4
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(1 ... 100, id: \.self) { cell in
                        Text("Cell \(cell)")
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .contentShape(Rectangle())
                            .background(Color.white)
                        
                            .addSwipeAction(menu: .swiped, isSwiped: $isSwiped) {
                                Leading {
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "checkmark.circle")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60, height: 60)
                                    .background(Color.green)
                                    
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "message")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue)
                                }
                                Trailing {
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "archivebox")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60, height: 60)
                                    .background(Color.gray)
                                    
                                    Button {
                                        print("remove \(cell)")
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.white)
                                    }
                                    .contentShape(Rectangle())
                                    .frame(width: 60, height: 60)
                                    .background(Color.red)
                                }
                            }
                    }
                }
            }
            .tabItem {
                Label("Swiped", systemImage: "rectangle.leadinghalf.inset.filled")
            }
            
            // Tab 5
            List {
                ForEach(viewModel.array.filter { !$0.isHidden } , id: \.id) { cell in
                    Text("Cell \(cell.number)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .addFullSwipeAction(menu: .slided, swipeColor: Color.red, isSwiped: $isSwiped) {
                            Leading {
                                Button {
                                    print("remove \(cell)")
                                } label: {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(.white)
                                }
                                .contentShape(Rectangle())
                                .frame(width: 60)
                                .frame(maxHeight: .infinity)
                                .background(Color.green)
                                
                                Button {
                                    print("remove \(cell)")
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
                                    print("remove \(cell)")
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
                            print(print("remove \(cell)"))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                                withAnimation {
                                    self.viewModel.hide(cell)
                                }
                            }
                        }
                        .listRowInsets(EdgeInsets())
                }
            }
            .listStyle(.plain)
            .tabItem {
                Label("List", systemImage: "square.split.1x2")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
