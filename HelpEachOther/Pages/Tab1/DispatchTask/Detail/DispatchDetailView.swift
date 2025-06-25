//
//  DispatchDetailPage.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//

import SwiftUI
import SwiftData
import MapKit
import Combine


/// 高级交互实现
/// 1. 滚动手势穿透（看起来像，但是用的是 offset）
/// 2. 随着滚动变化的顶部导航栏
struct DispatchTaskDetailView: View {
    var task: DispatchTask
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 23.129163, longitude: 113.264435),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    @State private var headerBackgroundVisible = false
    @State private var scrollOffset: CGFloat = 0
    private let mapHeight: CGFloat = 400
    
    var body: some View {
        GeometryReader { proxy in
            let safeArea = proxy.safeAreaInsets.top + proxy.safeAreaInsets.bottom
           
            // 可滚动的详情内容
            ScrollViewOffset {
                scrollOffset = $0
            } content: {
                // 使用ZStack来控制地图位置
                ZStack(alignment: .top) {
                    // 地图视图，根据滚动偏移量调整位置
                    // 这里还可以实现拉伸增加地图高度等优化
                        MapView(region: $region).frame(height: mapHeight + 100 + safeArea).offset(y: -(scrollOffset + 100))
                   
                    
                    // 内容视图
                    VStack(spacing: 0) {
                        // 透明占位符，与地图高度相同
                        Color.clear
                            .frame(height: mapHeight)
                        
                        // 详情内容
                        VStack(alignment: .leading, spacing: 0) {
                            // 滑动指示器
                            HStack {
                                Spacer()
                                Color.gray.opacity(0.15)
                                    .frame(width: 60, height: 10)
                                    .cornerRadius(10)
                                Spacer()
                            }
                            .padding(.top)
                            
                            // 详情内容
                            VStack(alignment: .leading, spacing: 16) {
                                // 倒计时和价格
                                HStack {
                                    CountdownView(minutes: 38, isExpired: false)
                                    Spacer()
                                    PriceView(price: task.price)
                                }
                                
                                // 标题
                                Text(task.title)
                                    .font(.title)
                                    .fontWeight(.bold)
                                
                                // 发布者信息
                                PublisherInfoView(publisher: task.publisher)
                                
                                Divider()
                                
                                // 服务详情
                                ServiceDetailsView(task: task)
                                
                                Divider()
                                
                                // 服务描述
                                ServiceDescriptionView(description: task.description)
                                
                                // 附件图片
                                if !task.attachmentImageURLs.isEmpty {
                                    AttachmentImagesView(images: task.attachmentImageURLs)
                                }
                                
                                // 底部额外空间，确保内容足够长
                                Color.white
                                    .frame(height: 200)
                                    .opacity(0)
                            }
                            .padding()
                        }
                        .background(Color.white)
                        .cornerRadius(20, corners: [.topLeft, .topRight])
                        .offset(y: -20)
                        .zIndex(2) // 确保内容在地图上方
                    }
                }
                .padding(.bottom, 80) // 为底部操作栏留出空间
                
            }

            
            // 顶部导航栏
            HeaderBar(scrollOffset: scrollOffset,title: task.title)
            
            // 底部操作栏
            VStack {
                Spacer()
                BottomActionBar()
                    .safeAreaPadding(.bottom)
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct HeaderBar: View {
    @Environment(\.dismiss) private var dismiss
    var scrollOffset: CGFloat = 0
    var title: String = ""
    
    var body: some View {
        let opacity = calculateOpacity(scrollOffset: scrollOffset)
        
       
            // 内容
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(opacity > 0.5 ? .black : .white)
                        .padding(12)
                        .background(
                            Circle()
                                .fill(opacity > 0.5 ? Color.white : Color.black.opacity(0.5))
                        )
                        .padding()
                }
                
                if opacity > 0.7 {
                    Text("\(title)")
                        .font(.headline)
                        .foregroundColor(.black)
                        .opacity((opacity - 0.7) * 3.3) // 标题文字渐变显示
                }
                
                Spacer()
            }.safeAreaPadding(.top)
            .padding(.top,12)
            .background(
                Color(.systemBackground)
                    .opacity(opacity)
                    .ignoresSafeArea(.all, edges: .top)
            ).animation(.easeInOut, value: opacity)
     
    }
    
    // 根据滚动值计算透明度
    private func calculateOpacity(scrollOffset: CGFloat) -> Double {
        // 滚动值为0时完全透明，滚动到-200时完全不透明
        let threshold: CGFloat = -200
        if scrollOffset >= 0 {
            return 0 // 未滚动时完全透明
        } else if scrollOffset <= threshold {
            return 1 // 滚动超过阈值时完全不透明
        } else {
            // 线性插值计算中间透明度
            return Double(-scrollOffset / threshold)
        }
    }
}


// 倒计时视图
struct CountdownView: View {
    var minutes: Int
    var isExpired: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            Text("\(minutes)分钟")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.orange)
            
            Text("投标关闭")
                .font(.system(size: 16))
                .foregroundColor(.secondary)
        }
    }
}

// 价格视图
struct PriceView: View {
    var price: Double
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 2) {
            Text("参考报价")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
            
            Text("\(Int(price))")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.red)
            
            Text("元")
                .font(.system(size: 16))
                .foregroundColor(.red)
        }
    }
}





struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    // 声明，数据由AI识别生成后期加以调整
    DispatchTaskDetailView(
        task: DispatchTask(
            id: "1",
            title: "帮我学习英语",
            category: "机会",
            way: "上门服务",
            publisher: UserInfo(
                id: "1",
                nickname: "Lisa",
                avatarURL: URL(string: "https://picsum.photos/200/300"),
                userTag: "Hiphop dancer"
            ),
            createdAt: Date(),
            price: 80,
            oldPrice: 100,
            serviceTimeStart: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
            serviceTimeEnd: Calendar.current.date(byAdding: .day, value: 1, to: Date())!.addingTimeInterval(30 * 60),
            location: "广州市番禺区钟村镇钟四环村路76号",
            description: "我希望找到一位可以教我英语的老师，提供线下教学，提升口语和写作能力。有耐心、有经验者优先，欢迎联系！",
            distance: 5.7,
            attachmentImageURLs: [
                // 用github项目图片
                URL(string: "https://github.com/yunhouhuang/HelpEachOther/blob/master/HelpEachOther/Assets.xcassets/image1.imageset/f427d3512531ea9c1569247de8c756d57c7c66bf.png")!,
                URL(string: "https://github.com/yunhouhuang/HelpEachOther/blob/master/HelpEachOther/Assets.xcassets/image2.imageset/b6e2be78e7b864dd6757a45d67856fdf6a8f4fea.png")!,
                URL(string: "https://github.com/yunhouhuang/HelpEachOther/blob/master/HelpEachOther/Assets.xcassets/iamge3.imageset/4681935c85a75da8ce2754872972abd0f95c959b.png")!,
                URL(string: "https://github.com/yunhouhuang/HelpEachOther/blob/master/HelpEachOther/Assets.xcassets/image4.imageset/c06803e25f03d97332d1c61edf7f881875e67579.png")!,
            ],
            status: .pending
        )
    )
}
