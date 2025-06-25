//
//  DateUtil.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//  时间工具类
//

import Foundation

class DateUtil {
    
    
    // 格式化日期
    static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date) + " - " + formatter.string(from: date.addingTimeInterval(3600))
    }

    // 计算时间差(分钟或小时或天)
    static func diffTime(_ date: Date) -> String {
        let now = Date()
        let diff = now.timeIntervalSince(date)
        let diffMinutes = Int(diff / 60)
        // 刚刚
        if diffMinutes < 1 {
            return "即时订单"
        }
        if diffMinutes < 60 {
            return "\(diffMinutes)分钟前"
        }
        let diffHours = Int(diff / 3600)
        if diffHours < 24 {
            return "\(diffHours)小时前"
        }
        let diffDays = Int(diff / 86400)
        return "\(diffDays)天前"
    }

    static func isInOneMinute(_ date: Date) -> Bool {
        let now = Date()
        let diff = now.timeIntervalSince(date)
        return diff < 60
    }
}
