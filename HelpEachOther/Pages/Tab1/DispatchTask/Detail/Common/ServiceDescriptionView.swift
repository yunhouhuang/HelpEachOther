//
//  ServiceDescriptionView.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/26.
//

import SwiftUI


// 服务描述视图
struct ServiceDescriptionView: View {
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(description)
                .font(.system(size: 16))
                .foregroundColor(.primary)
                .lineSpacing(4)
        }
    }
}
