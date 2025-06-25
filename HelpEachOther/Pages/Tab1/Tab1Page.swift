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
                
                // 筛选框
                HStack {
                    HStack {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .foregroundColor(.gray)
                        TextField("筛选", text: $searchText)
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "mic.fill")
                            .foregroundColor(.gray)
                            .padding(10)
                            .background(Color(UIColor.systemGray6))
                            .clipShape(Circle())
                    }
                }
                .padding(.vertical, 2)
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
                VStack{}.frame(width: 200,height: 20000).background(.red)
            }
        }
    }
}

#Preview {
    Tab1Page()
}
