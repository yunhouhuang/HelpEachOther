//
//  DispathTask.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//  声明：为了效率，这里由 AI 生成的 Model 然后进行微调
//

import Foundation

struct DispatchTask: Identifiable, Codable {
    let id: String                     // 唯一任务 ID，由后端提供
    var title: String                  // 任务标题，例如“帮我学习英语”
    var category: String               // 任务类型，例如“上门服务”、“远程服务”
    
    // 发布者信息
    var publisher: UserInfo            // 发布人信息
    var createdAt: Date                // 发布时间
    var expectedPrice: Double          // 参考报价，单位：元

    // 服务要求
    var serviceTimeStart: Date         // 服务开始时间
    var serviceTimeEnd: Date?          // 服务结束时间（可选）
    var location: String               // 服务地址
    var description: String            // 详细说明

    // 附件/图片
    var attachmentImageURLs: [URL]     // 附加图片
    
    // 任务状态
    var status: TaskStatus             // 当前任务状态（待抢单、已接单、已完成等）
}

/// 发布者信息
struct UserInfo: Codable {
    var userId: String
    var nickname: String
    var avatarURL: URL?
    var userTag: String?               // 自我标签或一句话介绍，例如“HipHop dancer”
}

/// 任务状态枚举
enum TaskStatus: String, Codable {
    case pending     // 待抢单
    case accepted    // 已接单
    case completed   // 已完成
    case cancelled   // 已取消
}

