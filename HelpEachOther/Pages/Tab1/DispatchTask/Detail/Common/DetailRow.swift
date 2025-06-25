//
//  DetailRow.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/26.
//

import SwiftUI


// 详情行
struct DetailRow: View {
    var title: String
    var content: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.secondary)
                .frame(width: 80, alignment: .leading)
            
            Text(content)
                .font(.system(size: 16))
                .foregroundColor(.primary)
        }
    }
}
