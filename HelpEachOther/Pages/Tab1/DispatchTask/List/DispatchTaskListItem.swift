//
//  DispatchTaskItem.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//

import SwiftUI

struct DispatchTaskListItem: View {
    var task: DispatchTask
    
    // 定义按钮回调事件
    
    private func getStatusText(task: DispatchTask) -> String {
        switch task.status {
        case .pending:
            return ""
        case .closed:
            return "投标关闭"
        case .completed:
            return ""
        default:
            return ""
        }
    }
    
    private func getStatusColor(task: DispatchTask) -> Color {
        switch task.status {
        case .pending:
            return .green
        case .closed:
            return .gray
        case .completed:
            return .gray
        default:
            return .gray
        }
    }
    
    var body: some View {
        let durationHours = getDurationHours(task: task)
        
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                /// 基本状态
                
                // 发布多久了
                Text("\(DateUtil.diffTime(task.createdAt))")
                    .font(.system(size: 16).weight(.bold))
                // 如果是1分钟内的订单显示绿色
                    .foregroundStyle(DateUtil.isInOneMinute(task.createdAt) ? .green : .orange)
                
                // 当前状态
                Text("\(getStatusText(task: task))")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(getStatusColor(task: task))
            }
            HStack {
                HStack(spacing: 8) {
                    // 默认处理
                    Text("\(task.way ?? "未知")")
                        .font(.system(size: 12))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                    Text(task.title)
                        .font(.system(size: 18, weight: .bold))
                }
                
                Spacer()
                VStack(alignment: .trailing) {
                    
                    HStack(alignment: .bottom, spacing: 2) {
                        // 如果有 oldPrice 则显示 oldPrice
                        if let oldPrice = task.oldPrice {
                            Text("\(Int(oldPrice))")
                                .font(.system(size: 14))
                                .foregroundStyle(.secondary)
                            // 划线
                                .strikethrough()
                        }else{
                            Text("参考报价")
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                         
                        }
                        Text("\(Int(task.price))")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundStyle(.red)
                        
                        Text("元")
                            .font(.system(size: 14))
                            .foregroundStyle(.red)
                            .padding(.bottom, 2)
                    }
                }
            }
                HStack(alignment: .top) {
                    if let distance = task.distance {
                        VStack{
                            Text(String(format: "%.1f", distance))
                                .font(.system(size: 18, weight: .bold))
                            Text("km")
                                .font(.system(size: 12))
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    
                    Text(task.location)
                        .font(.system(size: 16))
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("时间：")
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                        Text(DateUtil.formattedDate(task.serviceTimeStart))
                            .font(.system(size: 14))
                    }
                    HStack {
                        Text("时长：")
                            .font(.system(size: 14))
                            .foregroundStyle(.secondary)
                        
                        Text("\(durationHours)小时")
                            .font(.system(size: 14))
                    }
                }
                
                // 抢单按钮
                if task.status == .pending {
                    Button(action: {
                        // 抢单操作
                    }) {
                        Text("抢单")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(8)
                }else if task.status == .closed {
                    Text("重新报价")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.orange.opacity(0.1))
                        .cornerRadius(8)
                }else if task.status == .completed {
                    
                }
            }
            .padding()
            // 使用自定义的颜色方案
            .background(.card)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    
}

// 预览
#Preview {
    let user = UserInfo(
        id: "user001",
        nickname: "张三",
        avatarURL: URL(string: "https://example.com/avatar1.jpg"),
        userTag: "英语教师"
    )
    
    let task = DispatchTask(
        id: "task001",
        title: "帮我学习英语",
        category: "上门服务",
        publisher: user,
        createdAt: Date(),
        price: 80.0,
        serviceTimeStart: Date(),
        serviceTimeEnd: Date().addingTimeInterval(3600),
        location: "湖南省邵阳市新邵县潭府乡 9 单元 82 室",
        description: "需要一位英语母语人士帮我练习英语口语，主要是商务英语对话。",
        attachmentImageURLs: [],
        status: .pending
    )
    
    return DispatchTaskListItem(task: task)
        .padding()
}


/// 计算时长（小时）
func getDurationHours(task: DispatchTask) -> Int {
    var duration: Double = 1.0 // 默认1小时
    
    if let serviceTimeEnd = task.serviceTimeEnd {
        duration = serviceTimeEnd.timeIntervalSince(task.serviceTimeStart)
    }
    
    return max(1, Int(duration / 3600)) // 至少返回1小时

}
