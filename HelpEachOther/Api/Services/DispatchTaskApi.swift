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
        // 异步请求，模拟网络延迟
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
    
    private var attachmentImageURLs = [
        // 用github项目图片
        URL(string: "https://github.com/yunhouhuang/HelpEachOther/blob/master/HelpEachOther/Assets.xcassets/image1.imageset/f427d3512531ea9c1569247de8c756d57c7c66bf.png")!,
        URL(string: "https://github.com/yunhouhuang/HelpEachOther/blob/master/HelpEachOther/Assets.xcassets/image2.imageset/b6e2be78e7b864dd6757a45d67856fdf6a8f4fea.png")!,
        URL(string: "https://github.com/yunhouhuang/HelpEachOther/blob/master/HelpEachOther/Assets.xcassets/iamge3.imageset/4681935c85a75da8ce2754872972abd0f95c959b.png")!,
        URL(string: "https://github.com/yunhouhuang/HelpEachOther/blob/master/HelpEachOther/Assets.xcassets/image4.imageset/c06803e25f03d97332d1c61edf7f881875e67579.png")!,
    ]
    
    // 声明：模拟数据 AI 生成
    private var mockTasks: [DispatchTask] {
        let user1 = UserInfo(
            id: "user001",
            nickname: "张三",
            avatarURL: URL(string: "https://example.com/avatar1.jpg"),
            userTag: "英语教师"
        )
        
        let user2 = UserInfo(
            id: "user002",
            nickname: "李四",
            avatarURL: URL(string: "https://example.com/avatar2.jpg"),
            userTag: "专业搬运工"
        )
        
        let user3 = UserInfo(
            id: "user003",
            nickname: "王五",
            avatarURL: URL(string: "https://example.com/avatar3.jpg"),
            userTag: "IT工程师"
        )
        
        // 模拟时间
        let now = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: now)!
        let nextWeek = Calendar.current.date(byAdding: .day, value: 7, to: now)!
        
        return [
            DispatchTask(
                id: "task001",
                title: "帮我辅导英语口语",
                category: "机会",
                way: "线上",
                publisher: user1,
                createdAt: now.addingTimeInterval(-100000),
                price: 80,
                oldPrice: 88,
                serviceTimeStart: tomorrow,
                serviceTimeEnd: Calendar.current.date(byAdding: .hour, value: 2, to: tomorrow),
                location: "", // 线上服务，无需地址
                description: "需要一位英语母语人士帮我练习英语口语，主要是商务英语对话。可通过Zoom或Teams进行远程辅导。",
                distance: nil, // 线上服务，无需距离
                attachmentImageURLs: attachmentImageURLs,
                status: .closed
            ),
            DispatchTask(
                id: "task002",
                title: "帮忙搬家",
                category: "销售",
                way: "上门",
                publisher: user2,
                createdAt: now.addingTimeInterval(-2992),
                price: 200.0,
                serviceTimeStart: nextWeek,
                serviceTimeEnd: Calendar.current.date(byAdding: .hour, value: 4, to: nextWeek),
                location: "广州市天河区天河路123号", // 上门服务，需要详细地址
                description: "从天河区搬到海珠区，有一些大件家具需要帮忙搬运。包括一张双人床、两个衣柜和一个书桌。",
                distance: 3.5, // 3.5公里
                attachmentImageURLs: [
                    URL(string: "https://example.com/moving1.jpg")!,
                    URL(string: "https://example.com/moving2.jpg")!
                ],
                status: .pending
            ),
            DispatchTask(
                id: "task003",
                title: "电脑系统重装",
                category: "需求",
                way: "上门",
                publisher: user3,
                createdAt: now,
                price: 150.0,
                serviceTimeStart: Calendar.current.date(byAdding: .day, value: 2, to: now)!,
                serviceTimeEnd: nil,
                location: "广州市白云区白云路456号", // 上门服务，需要详细地址
                description: "笔记本电脑需要重装系统，并安装一些常用软件。电脑型号是MacBook Pro 2021，需要安装最新的macOS系统。",
                distance: 8.2, // 8.2公里
                attachmentImageURLs: attachmentImageURLs,
                status: .accepted
            ),
            DispatchTask(
                id: "task004",
                title: "陪我打篮球",
                category: "需求",
                way: "线下",
                publisher: user1,
                createdAt: Calendar.current.date(byAdding: .day, value: -1, to: now)!,
                price: 80.0,
                serviceTimeStart: Calendar.current.date(byAdding: .day, value: 3, to: now)!,
                serviceTimeEnd: Calendar.current.date(byAdding: .hour, value: 2, to: Calendar.current.date(byAdding: .day, value: 3, to: now)!)!,
                location: "广州市天河体育中心篮球场3号场", // 线下活动，需要详细地址
                description: "找一位篮球爱好者一起打球，水平不限，主要是交朋友。我打球水平一般，希望能找到耐心指导的伙伴。",
                distance: 5.7, // 5.7公里
                attachmentImageURLs: attachmentImageURLs,
                status: .pending
            ),
            DispatchTask(
                id: "task005",
                title: "帮忙遛狗",
                category: "采购",
                way: "上门",
                publisher: user2,
                createdAt: Calendar.current.date(byAdding: .day, value: -2, to: now)!,
                price: 50.0,
                serviceTimeStart: Calendar.current.date(byAdding: .day, value: 1, to: now)!,
                serviceTimeEnd: nil,
                location: "广州市海珠区滨江路789号", // 上门服务，需要详细地址
                description: "需要有经验的人帮忙遛狗，金毛犬，性格温顺。每天早晚各一次，每次30分钟左右。",
                distance: 12.3, // 12.3公里
                attachmentImageURLs: [
                    URL(string: "https://example.com/dog.jpg")!
                ],
                status: .completed
            ),
            DispatchTask(
                id: "task006",
                title: "远程数据分析",
                category: "机会",
                way: "线上",
                publisher: user3,
                createdAt: now.addingTimeInterval(-5000),
                price: 300.0,
                serviceTimeStart: Calendar.current.date(byAdding: .day, value: 2, to: now)!,
                serviceTimeEnd: Calendar.current.date(byAdding: .day, value: 5, to: now)!,
                location: "", // 线上服务，无需地址
                description: "需要一位数据分析师帮忙分析一批销售数据，并制作可视化报表。数据格式为Excel，约5000条记录。",
                distance: nil, // 线上服务，无需距离
                attachmentImageURLs: attachmentImageURLs,
                status: .pending
            ),
            DispatchTask(
                id: "task007",
                title: "门店咨询服务",
                category: "销售",
                way: "门店",
                publisher: user1,
                createdAt: now.addingTimeInterval(-50000),
                price: 120.0,
                serviceTimeStart: tomorrow,
                serviceTimeEnd: Calendar.current.date(byAdding: .hour, value: 3, to: tomorrow),
                location: "广州市越秀区中山五路88号", // 门店服务，需要详细地址
                description: "需要一位有销售经验的人员在我的服装店帮忙提供客户咨询服务，主要负责介绍产品和促成交易。",
                distance: 15.8, // 15.8公里
                attachmentImageURLs: attachmentImageURLs,
                status: .pending
            )
        ]
    }
}
