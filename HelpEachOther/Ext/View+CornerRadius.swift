//
//  View+CornerRadius.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/26.
//

import Foundation
import SwiftUI

// 圆角扩展,可以用此方式来封装更多的通用样式规则，Demo不再写更多
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
