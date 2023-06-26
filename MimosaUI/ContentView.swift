//
//  ContentView.swift
//  MimosaUI
//
//  Created by Ziyuan Qu on 2023/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationSplitView {
            Sidebar()
        } detail: {
            ScenesUI()
        }
        .navigationTitle("All Boards")
        .searchable(text: $searchText)
    }
}

struct BoardView: View {
    @State private var isInspectorPresented = true
    @State private var selectedIndex = 2
        
    var body: some View {
        Text("Rendering")
            .navigationBarBackButtonHidden(false)
            .navigationTitle("Rendering")
            .inspector(isPresented: $isInspectorPresented) {
                InspectorView(selectedIndex: $selectedIndex)
                .inspectorColumnWidth(min: 200, ideal: 300, max: 400)
                .toolbar {
                    Button(action: { isInspectorPresented.toggle() }) {
                        Label("Toggle Inspector", systemImage: "sidebar.right")
                    }
                }
            }
    }
}

struct InspectorView: View {
    @Binding var selectedIndex: Int
//    @State private var selection: Int = 0
    
    var body: some View {
        List {
            Text("Integrators")
                .font(.headline)
            Picker(selection: $selectedIndex, label: EmptyView()) {
                Text("BRDF").tag(0)
                Text("NEE").tag(1)
                Text("MIS").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedIndex){
                print("change selection")
            }
            Divider()
//            Picker(selection: $selection, label: Text("Picker Label")) {
//                Text("Option 1").tag(0)
//                Text("Option 2").tag(1)
//                Text("Option 3").tag(2)
//            }
        }
        .listStyle(SidebarListStyle())
//        .frame(minWidth: 100)
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
    @State private var isCardView = true
    
    let boards = [
        ("Scene 1", "1 hour ago"),
        ("Scene 2", "2 hours ago"),
        ("Scene 3", "3 hours ago")
    ]
    
    var body: some View {
        NavigationStack {
            if isCardView {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 220))]) {
                        ForEach(boards, id: \.0) { board in
                            NavigationStack() {
                                NavigationLink(destination:BoardView()){
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
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                .background(Color.white)
            } else {
                List {
                    ForEach(boards, id: \.0) { board in
                        NavigationStack() {
                            NavigationLink(destination:BoardView()) {
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
        .navigationTitle("All Scenes")
        .toolbar {
            Button(action: { isCardView.toggle() }) {
                Image(systemName: isCardView ? "list.bullet" : "square.grid.2x2")
            }
        }
    }
}
