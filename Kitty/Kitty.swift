//
//  Kitty.swift
//  Kitty
//
//  Created by Doug on 11/6/24.
//

import Foundation
import SwiftData

@Model
final class Kitty {
    var name: String
    var age: Int
    var emoji: String
    
    init(name: String, age: Int, emoji: String) {
        self.name = name
        self.age = age
        self.emoji = emoji
    }
}
