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
    init() {
        // Adjust navigation bar title fonts
        let appearance = UINavigationBarAppearance()        
        appearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .regular)
        ]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
            KittyView()
        }
        .modelContainer(for: Kitty.self)
    }

}
