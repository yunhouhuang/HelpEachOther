//
//  HelpEachOtherApp.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//

import SwiftUI
import SwiftData

@main
struct HelpEachOtherApp: App {
    // 放这里的原因是为了避免重复创建ViewModel，当然也可以放在ContentView中
    @StateObject private var dispatchListViewModel = DispatchListViewModel()
  
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dispatchListViewModel)
        }
    }
}
