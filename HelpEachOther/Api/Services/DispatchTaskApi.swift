//
//  DispatchTaskApi.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//

import Foundation
import Combine

class DispatchTaskApi {
    
    static let shared = DispatchTaskApi()
    
    private init() {}
    
    // 获取任务列表
    func fetchList() -> AnyPublisher<[DispatchTask], Error> {
        // 模拟网络延迟
        return Future<[DispatchTask], Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                promise(.success(self.mockTasks))
            }
        }
        .eraseToAnyPublisher()
    }
    
    // 获取任务详情
    func fetchDetail(taskId: String) -> AnyPublisher<DispatchTask, Error> {
        return Future<DispatchTask, Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if let task = self.mockTasks.first(where: { $0.id == taskId }) {
                    promise(.success(task))
                } else {
                    promise(.failure(APIError.notFound))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    // 模拟错误类型
    enum APIError: Error {
        case notFound
        case networkError
        case serverError
    }
    
    // 声明：模拟数据 AI 生成
    private var mockTasks: [DispatchTask] {
        let user1 = UserInfo(
            userId: "user001",
            nickname: "张三",
            avatarURL: URL(string: "https://example.com/avatar1.jpg"),
            userTag: "英语教师"
        )
        
        let user2 = UserInfo(
            userId: "user002",
            nickname: "李四",
            avatarURL: URL(string: "https://example.com/avatar2.jpg"),
            userTag: "专业搬运工"
        )
        
        let user3 = UserInfo(
            userId: "user003",
            nickname: "王五",
            avatarURL: URL(string: "https://example.com/avatar3.jpg"),
            userTag: "IT工程师"
        )
        
        let now = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now)!
        let nextWeek = Calendar.current.date(byAdding: .day, value: 7, to: now)!
        
        return [
            DispatchTask(
                id: "task001",
                title: "帮我辅导英语口语",
                category: "远程服务",
                publisher: user1,
                createdAt: now,
                expectedPrice: 100.0,
                serviceTimeStart: tomorrow,
                serviceTimeEnd: Calendar.current.date(byAdding: .hour, value: 2, to: tomorrow),
                location: "线上",
                description: "需要一位英语母语人士帮我练习英语口语，主要是商务英语对话。",
                attachmentImageURLs: [],
                status: .pending
            ),
            DispatchTask(
                id: "task002",
                title: "帮忙搬家",
                category: "上门服务",
                publisher: user2,
                createdAt: now,
                expectedPrice: 200.0,
                serviceTimeStart: nextWeek,
                serviceTimeEnd: Calendar.current.date(byAdding: .hour, value: 4, to: nextWeek),
                location: "广州市天河区天河路123号",
                description: "从天河区搬到海珠区，有一些大件家具需要帮忙搬运。",
                attachmentImageURLs: [
                    URL(string: "https://example.com/moving1.jpg")!,
                    URL(string: "https://example.com/moving2.jpg")!
                ],
                status: .pending
            ),
            DispatchTask(
                id: "task003",
                title: "电脑系统重装",
                category: "上门服务",
                publisher: user3,
                createdAt: now,
                expectedPrice: 150.0,
                serviceTimeStart: Calendar.current.date(byAdding: .day, value: 2, to: now)!,
                serviceTimeEnd: nil,
                location: "广州市白云区白云路456号",
                description: "笔记本电脑需要重装系统，并安装一些常用软件。",
                attachmentImageURLs: [],
                status: .accepted
            ),
            DispatchTask(
                id: "task004",
                title: "陪我打篮球",
                category: "线下活动",
                publisher: user1,
                createdAt: Calendar.current.date(byAdding: .day, value: -1, to: now)!,
                expectedPrice: 80.0,
                serviceTimeStart: Calendar.current.date(byAdding: .day, value: 3, to: now)!,
                serviceTimeEnd: Calendar.current.date(byAdding: .hour, value: 2, to: Calendar.current.date(byAdding: .day, value: 3, to: now)!)!,
                location: "广州市天河体育中心",
                description: "找一位篮球爱好者一起打球，水平不限，主要是交朋友。",
                attachmentImageURLs: [],
                status: .pending
            ),
            DispatchTask(
                id: "task005",
                title: "帮忙遛狗",
                category: "宠物服务",
                publisher: user2,
                createdAt: Calendar.current.date(byAdding: .day, value: -2, to: now)!,
                expectedPrice: 50.0,
                serviceTimeStart: Calendar.current.date(byAdding: .day, value: 1, to: now)!,
                serviceTimeEnd: nil,
                location: "广州市海珠区滨江路789号",
                description: "需要有经验的人帮忙遛狗，金毛犬，性格温顺。",
                attachmentImageURLs: [
                    URL(string: "https://example.com/dog.jpg")!
                ],
                status: .completed
            )
        ]
    }
}
