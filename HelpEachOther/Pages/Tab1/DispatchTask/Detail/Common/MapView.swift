//
//  MapView.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/26.
//

import SwiftUI
import Combine
import MapKit

// 地图视图
struct MapView: View {
    @Binding var region: MKCoordinateRegion
    
    var body: some View {
        // todo 地图需要处理中心点偏移
        Map(coordinateRegion: $region, interactionModes: .all)
            .overlay(
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.blue)
                    .offset(y: -15)
            )
    }
}
