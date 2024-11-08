//
//  KittyApp.swift
//  Kitty
//
//  Created by Doug on 11/6/24.
//

import SwiftUI
import SwiftData

@main
struct KittyApp: App {
    var body: some Scene {
        WindowGroup {
            KittyView()
        }
        .modelContainer(for: Kitty.self)
    }
}
