//
//  AttachmentImagesView.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/26.
//

import SwiftUI


// 图片视图, 支持多张图片,第一张 4:3 全宽，第二张 三分之二宽 1:1，其余 1:1 三分之一宽
struct AttachmentImagesView: View {
    var images: [URL]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("附件")
                .font(.system(size: 16, weight: .medium))
            
            if images.isEmpty {
                EmptyView()
            } else {
                VStack(spacing: 8) {
                    // 第一张图片：4:3全宽
                    if images.count > 0 {
                        AsyncImage(url: images[0]) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray.opacity(0.1)
                        }
                        .frame(height: UIScreen.main.bounds.width * 0.8)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    // 第二张图片和其余图片
                    if images.count > 1 {
                        HStack(spacing: 8) {
                            // 第二张图片：三分之二宽，1:1
                            AsyncImage(url: images[1]) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Color.gray.opacity(0.1)
                            }
                            .frame(height: UIScreen.main.bounds.width * 0.6)
                            .frame(width: UIScreen.main.bounds.width * 0.6)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            // 第三张图片（如果有）：三分之一宽，1:1
                            if images.count > 2 {
                                VStack(spacing: 8) {
                                    AsyncImage(url: images[2]) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Color.gray.opacity(0.1)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                    
                                    // 第四张图片（如果有）：三分之一宽，1:1
                                    if images.count > 3 {
                                        AsyncImage(url: images[3]) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                        } placeholder: {
                                            Color.gray.opacity(0.1)
                                        }
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                    }
                    
                    // 如果有超过4张图片，显示更多图片的网格
                    if images.count > 4 {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 8),
                            GridItem(.flexible(), spacing: 8),
                            GridItem(.flexible(), spacing: 8)
                        ], spacing: 8) {
                            ForEach(4..<min(images.count, 10), id: \.self) { index in
                                AsyncImage(url: images[index]) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Color.gray.opacity(0.1)
                                }
                                .aspectRatio(1, contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                        .frame(height: CGFloat((min(images.count, 10) - 4 + 2) / 3) * 100)
                    }
                }
            }
        }
    }
}
