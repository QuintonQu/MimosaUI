//
//  ContentView.swift
//  MimosaUI
//
//  Created by Ziyuan Qu on 2023/6/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            Sidebar()
        } detail: {
            ScenesUI()
        }
        .navigationTitle("All Boards")
    }
}

struct BoardView: View {
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        Text("Board Details")
            .navigationBarBackButtonHidden(false)
            .navigationTitle("Board Details")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Sidebar: View {
    var body: some View {
        List {
            NavigationLink(destination: Text("Item 1")) {
                Label("Item 1", systemImage: "star.fill")
            }
            NavigationLink(destination: Text("Item 2")) {
                Label("Item 2", systemImage: "star.fill")
            }
            NavigationLink(destination: Text("Item 3")) {
                Label("Item 3", systemImage: "star.fill")
            }
        }
        .listStyle(SidebarListStyle())
        .frame(minWidth: 100)
    }
}

struct ScenesUI: View {
    @State private var searchText = ""
    @State private var isCardView = true
    
    let boards = [
        ("Board 1", "1 hour ago"),
        ("Board 2", "2 hours ago"),
        ("Board 3", "3 hours ago")
    ]
    
    var body: some View {
        NavigationStack {
            if isCardView {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 200))]) {
                        ForEach(boards, id: \.0) { board in
                            NavigationStack() {
                                ZStack(alignment: .bottom) {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .frame(width: 200, height: 200)
                                    
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.7))
                                        .frame(height: 50)
                                    
                                    VStack(alignment: .leading) {
                                        Text(board.0)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text("Last opened: \(board.1)")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                }
                                .cornerRadius(10)
                                .padding()
//                                .navigationDestination(isPresented: false, destination: BoardView())
                                .navigationTitle("All Boards")
                            }
                        }
                    }
                }
            } else {
                List {
                    ForEach(boards, id: \.0) { board in
                        NavigationStack() {
                            HStack {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                VStack(alignment: .leading) {
                                    Text(board.0)
                                    Text("Last opened: \(board.1)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("All Boards")
        .toolbar {
            Button(action: { isCardView.toggle() }) {
                Image(systemName: isCardView ? "list.bullet" : "square.grid.2x2")
            }
        }
        .searchable(text: $searchText)
    }
}
