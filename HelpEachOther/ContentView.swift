//
//  ContentView.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    @State var paths:NavigationPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $paths) {
            TabBarView()
        }
    }
}

#Preview {
    ContentView()
}
