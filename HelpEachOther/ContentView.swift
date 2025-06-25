//
//  ContentView.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State var paths:NavigationPath = NavigationPath()

    // todo 这里可以添加 N 个 View 来包裹，也可以添加常见的 app 打开、前台切换、后台切换等，可以使用SwiftUI 也可以 UIKit
    var body: some View {
        NavigationStack(path: $paths) {
            TabBarView()
        }
    }
}

#Preview {
    // 提供必要的环境，防止崩溃
    ContentView()
        .environmentObject(DispatchListViewModel()) // 提供ViewModel作为环境对象
        .onAppear {
            // 预加载一些数据或设置
            print("ContentView Preview loaded")
        }
}
