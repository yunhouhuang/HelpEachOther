//
//  ServiceDetailsView.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/26.
//

import SwiftUI


// 服务详情视图
struct ServiceDetailsView: View {
    var task: DispatchTask
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // 服务类型
            DetailRow(title: "服务类型", content: task.way ?? "未指定")
            
            // 服务时间
            DetailRow(title: "服务时间", content: formattedDateTime(task.serviceTimeStart, task.serviceTimeEnd))
            
            // 服务地址
            DetailRow(title: "服务地址", content: task.location.isEmpty ? "线上服务" : task.location)
        }
    }
    
    private func formattedDateTime(_ start: Date, _ end: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy 年 MM 月 dd 日 HH:mm"
        
        if let end = end {
            let endFormatter = DateFormatter()
            endFormatter.dateFormat = "HH:mm"
            return "\(formatter.string(from: start)) - \(endFormatter.string(from: end))"
        } else {
            return formatter.string(from: start)
        }
    }
}
