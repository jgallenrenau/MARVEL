//
//  Item.swift
//  Marvel
//
//  Created by Jordi Gallen Renau on 15/1/25.
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
