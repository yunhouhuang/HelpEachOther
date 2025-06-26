//
//  TabBarView.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                // 好嘢 Tab
                NavigationView {
                    Tab1Page()
                        .navigationBarHidden(true)
                        // 添加底部安全区域，防止内容被TabBar遮挡
                        .safeAreaInset(edge: .bottom) {
                            Color.clear.frame(height: 49)
                        }
                }
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("好嘢")
                }
                .tag(0)
                
                // 死党 Tab
                NavigationView {
                    Tab2Page()
                        .navigationBarHidden(true)
                        .safeAreaInset(edge: .bottom) {
                            Color.clear.frame(height: 49)
                        }
                }
                .tabItem {
                    Image(systemName: "person.2.fill")
                    Text("死党")
                }
                .tag(1)
                
                // 搜索 Tab
                NavigationView {
                    Tab3Page()
                        .navigationBarHidden(true)
                        .safeAreaInset(edge: .bottom) {
                            Color.clear.frame(height: 49)
                        }
                }
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("搜索")
                }
                .tag(2)
                
                // 档案 Tab
                NavigationView {
                    Tab4Page()
                        .navigationBarHidden(true)
                        .safeAreaInset(edge: .bottom) {
                            Color.clear.frame(height: 49)
                        }
                }
                .tabItem {
                    Image(systemName: "folder.fill")
                    Text("档案")
                }
                .tag(3)
                
                // 点做 Tab
                NavigationView {
                    Tab5Page()
                        .navigationBarHidden(true)
                        .safeAreaInset(edge: .bottom) {
                            Color.clear.frame(height: 49)
                        }
                }
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("点做")
                }
                .tag(4)
            }
            .ignoresSafeArea(.keyboard) // 防止键盘弹出时TabBar上移
        }
    }
}
#Preview {
    TabBarView()
        .environmentObject(DispatchListViewModel())
}
