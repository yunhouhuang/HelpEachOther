//
//  DispatchListViewModel.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//

import Foundation
import Combine

class DispatchListViewModel: ObservableObject {
    @Published var tasks: [DispatchTask] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Combine 框架发布订阅
    private var cancellables = Set<AnyCancellable>()
    
    func fetchTasks() {
        isLoading = true
        errorMessage = nil
        API.dispatchTask.fetchList()
            // 这里需要在主线线程去处理UI数据，不然UI不会刷新
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] tasks in
                self?.tasks = tasks
            })
            .store(in: &cancellables)
    }
}
