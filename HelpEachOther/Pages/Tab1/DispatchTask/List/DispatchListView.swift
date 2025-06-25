//
//  DispatchList.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//

import SwiftUI

struct DispatchListView: View {
    // 使用 view model
    @ObservedObject var viewModel: DispatchListViewModel
    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView()
            }  else if viewModel.tasks.isEmpty {
                Text("暂无任务")
                    .foregroundStyle(.gray)
                    .padding()
            } else {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.tasks) { task in
                        ///
                        NavigationLink {
                            DispatchTaskDetailView(task: task)
                        } label: {
                            // 去除链接样式
                            DispatchTaskListItem(task: task)
                                .id(task.id)
                                
                        }.buttonStyle(PlainButtonStyle())

                      
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            if viewModel.tasks.isEmpty {
                viewModel.fetchTasks()
            }
        }
    }
}

#Preview {
    DispatchListView(viewModel: DispatchListViewModel())
}
