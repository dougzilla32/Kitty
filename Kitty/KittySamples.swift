//
//  KittySamples.swift
//  Kitty
//
//  Created by Doug on 11/7/24.
//

import Foundation
import SwiftData

let catEmojis = [
    "🐱", // Cat Face
    "🐈", // Cat
    "🐈‍⬛", // Black Cat
    "😺", // Grinning Cat Face
    "😸", // Grinning Cat Face with Smiling Eyes
    "😹", // Cat Face with Tears of Joy
    "😻", // Smiling Cat Face with Heart-Eyes
    "😼", // Cat Face with Wry Smile
    "😽", // Kissing Cat Face
    "🙀", // Weary Cat Face
    "😿", // Crying Cat Face
    "😾"  // Pouting Cat Face
]

class KittySamples {
    static let shared = KittySamples()
    
    func generateSampleKitties() -> [Kitty] {
        let kittyData = [
            ("Sir Purrs-a-Lot", 2),
            ("Whisker McFluff", 3),
            ("Captain Cuddles", 4),
            ("Lady Meowington", 1),
            ("Professor Paws", 5),
            ("Duchess Furrball", 2),
            ("Mr. Snugglepuss", 3),
            ("Countess Clawdia", 4),
            ("Baron von Fur", 1),
            ("Princess Purrfect", 5)
        ]
        var kitties = [Kitty]()
        for (name, age) in kittyData {
            let kitty = Kitty(name: name, age: age, emoji: catEmojis.randomElement()!)
            kitties.append(kitty)
        }
        return kitties
    }

    func populateSampleDataIfNeeded(modelContext: ModelContext) {
        let userDefaults = UserDefaults.standard
        let hasLaunchedBeforeKey = "hasLaunchedBefore"

        if !userDefaults.bool(forKey: hasLaunchedBeforeKey) {
            // First launch: populate sample data
            let sampleKitties = generateSampleKitties()
            do {
                // Access the existing ModelContext from the environment
                for kitty in sampleKitties {
                    modelContext.insert(kitty)
                }
                try modelContext.save()
                userDefaults.set(true, forKey: hasLaunchedBeforeKey)
            } catch {
                print("Failed to save sample kitties: \(error)")
            }
        }
    }

    @MainActor
    func createPreviewModelContainer() -> ModelContainer {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Kitty.self, configurations: configuration)
            let sampleKitties = generateSampleKitties()
            for kitty in sampleKitties {
                container.mainContext.insert(kitty)
            }
            return container
        } catch {
            fatalError("Failed to create preview model container: \(error)")
        }
    }

}
