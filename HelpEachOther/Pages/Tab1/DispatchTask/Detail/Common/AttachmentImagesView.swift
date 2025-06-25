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
    
    // 屏幕宽度
    @Environment(\.layoutDirection) private var layoutDirection
    private var screenWidth: CGFloat {
        UIScreen.main.bounds.width - 32 // 减去左右padding
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("附件")
                .font(.system(size: 16, weight: .medium))
            
            if images.isEmpty {
                EmptyView()
            } else {
                // 使用共享布局组件
                ImageGridLayout(images: images, screenWidth: screenWidth)
            }
        }
    }
}

// 共享布局组件
struct ImageGridLayout: View {
    let images: [URL]
    let screenWidth: CGFloat
    
    // 计算尺寸
    private var firstImageHeight: CGFloat { screenWidth * 0.75 } // 4:3 比例
    private var secondImageWidth: CGFloat { screenWidth * 0.66 } // 三分之二宽
    private var thirdImageWidth: CGFloat { screenWidth * 0.33 } // 三分之一宽
    
    // 计算第3和第4张图片的高度（正方形）
    private var smallImageSize: CGFloat {
        // 第二张图片高度减去中间间距，再除以2
        (secondImageWidth - 8) / 2
    }
    
    var body: some View {
        VStack(spacing: 8) {
            // 第一张图片：4:3全宽
            if !images.isEmpty {
                ImageItem(url: images[0], width: screenWidth, height: firstImageHeight)
            }
            
            // 第二行：第二张图片(2/3宽)和右侧区域(1/3宽，包含第三、四张图片)
            if images.count > 1 {
                HStack(spacing: 8) {
                    // 第二张图片：三分之二宽，1:1
                    ImageItem(url: images[1], width: secondImageWidth, height: secondImageWidth)
                    
                    // 右侧区域：包含第三、四张图片
                    if images.count > 2 {
                        VStack(spacing: 8) {
                            // 第三张图片
                            ImageItem(url: images[2], width: thirdImageWidth, height: smallImageSize)
                            
                            // 第四张图片
                            if images.count > 3 {
                                ImageItem(url: images[3], width: thirdImageWidth, height: smallImageSize)
                            } else {
                                Spacer()
                                    .frame(width: thirdImageWidth, height: smallImageSize)
                            }
                        }
                    } else {
                        // 如果没有第三张图片，添加空白占位符
                        Spacer()
                            .frame(width: thirdImageWidth)
                    }
                }
                .frame(height: secondImageWidth)
            }
            
            // 第三行：超过4张的图片使用网格布局
            if images.count > 4 {
                // 计算额外图片行数
                let remainingCount = min(images.count - 4, 6) // 最多显示额外6张
                let rows = (remainingCount + 2) / 3 // 每行3张，向上取整
                
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 8),
                    GridItem(.flexible(), spacing: 8),
                    GridItem(.flexible(), spacing: 8)
                ], spacing: 8) {
                    ForEach(4..<min(images.count, 10), id: \.self) { index in
                        let gridItemWidth = (screenWidth / 3 - 6)
                        ImageItem(url: images[index], width: gridItemWidth, height: gridItemWidth)
                    }
                }
                .frame(height: CGFloat(rows) * (screenWidth / 3 - 6 + 8) - 8)
                
                // 如果有更多图片，显示"更多"提示
                if images.count > 10 {
                    Text("还有\(images.count - 10)张图片")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 4)
                }
            }
        }
    }
}

// 单个图片项组件
struct ImageItem: View {
    let url: URL
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
            case .failure:
                ZStack {
                    Color.gray.opacity(0.1)
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                }
                .frame(width: width, height: height)
            case .empty:
                ZStack {
                    Color.gray.opacity(0.1)
                    ProgressView()
                }
                .frame(width: width, height: height)
            @unknown default:
                Color.gray.opacity(0.1)
                    .frame(width: width, height: height)
            }
        }
        .cornerRadius(8)
    }
}

// 预览
struct AttachmentImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack {
                // 1张图片
                AttachmentImagesView(images: [
                    URL(string: "https://picsum.photos/800/600")!
                ])
                .padding()
                .background(Color.white)
                
                // 2张图片
                AttachmentImagesView(images: [
                    URL(string: "https://picsum.photos/800/600")!,
                    URL(string: "https://picsum.photos/801/600")!
                ])
                .padding()
                .background(Color.white)
                
                // 3张图片
                AttachmentImagesView(images: [
                    URL(string: "https://picsum.photos/800/600")!,
                    URL(string: "https://picsum.photos/801/600")!,
                    URL(string: "https://picsum.photos/802/600")!
                ])
                .padding()
                .background(Color.white)
                
                // 4张图片
                AttachmentImagesView(images: [
                    URL(string: "https://picsum.photos/800/600")!,
                    URL(string: "https://picsum.photos/801/600")!,
                    URL(string: "https://picsum.photos/802/600")!,
                    URL(string: "https://picsum.photos/803/600")!
                ])
                .padding()
                .background(Color.white)
                
                // 多张图片
                AttachmentImagesView(images: [
                    URL(string: "https://picsum.photos/800/600")!,
                    URL(string: "https://picsum.photos/801/600")!,
                    URL(string: "https://picsum.photos/802/600")!,
                    URL(string: "https://picsum.photos/803/600")!,
                    URL(string: "https://picsum.photos/804/600")!,
                    URL(string: "https://picsum.photos/805/600")!,
                    URL(string: "https://picsum.photos/806/600")!,
                    URL(string: "https://picsum.photos/807/600")!,
                    URL(string: "https://picsum.photos/808/600")!,
                    URL(string: "https://picsum.photos/809/600")!,
                    URL(string: "https://picsum.photos/810/600")!
                ])
                .padding()
                .background(Color.white)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
        }
    }
}
