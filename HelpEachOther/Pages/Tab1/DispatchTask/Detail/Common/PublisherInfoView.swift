//
//  PublisherInfoView.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/26.
//

import SwiftUI


// 发布者信息视图
struct PublisherInfoView: View {
    var publisher: UserInfo
    
    var body: some View {
        HStack(spacing: 12) {
            // 头像
            AsyncImage(url: publisher.avatarURL) { image in
                image.resizable()
            } placeholder: {
                Color.gray.opacity(0.1)
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            // 名称和标签
            VStack(alignment: .leading, spacing: 4) {
                Text(publisher.nickname)
                    .font(.system(size: 18, weight: .medium))
                
                if let userTag = publisher.userTag {
                    Text(userTag)
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
