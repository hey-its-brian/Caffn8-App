//
//  Item.swift
//  Caffn8
//
//  Created by Brian Meyer on 4/5/26.
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
