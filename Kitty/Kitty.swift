//
//  Kitty.swift
//  Kitty
//
//  Created by Doug on 11/6/24.
//

import SwiftData

@Model
final class Kitty {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}
