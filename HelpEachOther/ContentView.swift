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

    // todo 这里可以添加 N 个 View 来包裹，也可以添加常见的 app 打开、前台切换、后台切换等，可以使用SwiftUI 也可以 UIKit
    var body: some View {
        NavigationStack(path: $paths) {
            TabBarView()
        }
    }
}

#Preview {
    ContentView()
}
