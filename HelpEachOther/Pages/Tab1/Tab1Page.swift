//
//  Tab1Page.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//

import SwiftUI

struct Tab1Page: View {
    var body: some View {
        VStack{
            VStack{
                HStack(alignment: .bottom){
                    Text("Today").font(Font.system(size: 32).bold())
                    Text("9月29日").font(Font.system(size: 24).bold()).foregroundStyle(.secondary)
                    Spacer()
                    Image("avatar").resizable().frame(width: 42, height: 42).clipShape(Circle())
                }.padding(.horizontal)
            }
            ScrollView(){
                
            }
            
            
        }
    }
}

#Preview {
    Tab1Page()
}
