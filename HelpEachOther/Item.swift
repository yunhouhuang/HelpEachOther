//
//  Item.swift
//  HelpEachOther
//
//  Created by 黄运厚 on 2025/6/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
