//
//  BottomActionBar.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/26.
//

import SwiftUI


// 底部操作栏
struct BottomActionBar: View {
    @State var show:Bool = false
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "message")
                    .foregroundColor(.primary)
                Text("联系")
                    .foregroundColor(.primary)
            }
            .frame(width: 100)
            .padding(.vertical, 12)
            
            Spacer()
            
            Button(action: {
                show = true
            }) {
                Text("抢单")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
            }
            .background(Color.red)
            .cornerRadius(8)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -2)
        .sheet(isPresented: $show) {
            VStack{
                VStack{
                    Text("这里是接单/抢单/投标")
                }
            }.frame(height: 400)
        }
    }
}


