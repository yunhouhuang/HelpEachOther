//
//  Tab1Page.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//

import SwiftUI

struct Tab1Page: View {
    @State private var searchText = ""
    @State private var selectedCategory = 0
    // 使用环境对象，可以避免重复创建ViewModel
    @EnvironmentObject private var dispatchListViewModel: DispatchListViewModel

    let categories = ["机会", "销售", "需求", "采购"]

    var body: some View {
        VStack{
            VStack{
                HStack(alignment: .bottom){
                    Text("Today").font(Font.system(size: 34).bold())
                    Text("9月29日").font(Font.system(size: 22).bold()).foregroundStyle(.secondary)
                    Spacer()
                    Image("avatar").resizable().frame(width: 34, height: 34).clipShape(Circle())
                }.padding(.horizontal)

                // 筛选框，todo 这里要处理键盘回收，demo意义不大这里先不写，点击非键盘区域，键盘回收
                HStack {
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundStyle(.gray)
                        TextField("筛选", text: $searchText)
                    }


                    Spacer()

                    Button(action: {}) {
                        Image(systemName: "mic.fill").foregroundStyle(.gray)
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)

                // 分类选择器
                Picker("类别", selection: $selectedCategory) {
                    ForEach(0..<categories.count, id: \.self) { index in
                        Text(categories[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
            }

            ScrollView(.vertical){
                DispatchListView(viewModel: dispatchListViewModel)
                    .padding(.top)
                // 贪欲占位符
                Color.clear
            }.background(.gray.opacity(0.1)).refreshable {
                // 下拉刷新，留坑，这个暂时不实现
            }
        }
        .onAppear {
            // 确保数据加载
            if dispatchListViewModel.tasks.isEmpty {
                dispatchListViewModel.fetchTasks()
            }
        }
    }
}

#Preview {
    Tab1Page()
        .environmentObject(DispatchListViewModel())
}
