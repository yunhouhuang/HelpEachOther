//
//  DispatchDetailPage.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//

import SwiftUI
import SwiftData

struct DispatchTaskDetailView: View {
    var task: DispatchTask
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    DispatchTaskDetailView(
        task: DispatchTask(
            id: "1",
            title: "测试",
            category: "测试",
            way: "测试",
            publisher: UserInfo(
                id: "1",
                nickname: "测试",
                avatarURL: URL(string: "https://picsum.photos/200/300"),
                userTag: "测试"
            ),
            createdAt: Date(),
            price: 100,
            oldPrice: 100,
            serviceTimeStart: Date(),
            serviceTimeEnd: Date(),
            location: "测试",
            description: "测试",
            attachmentImageURLs: [], status: TaskStatus.accepted,
        )
    )
}
