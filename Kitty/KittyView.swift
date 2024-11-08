//
//  ContentView.swift
//  Kitty
//
//  Created by Doug on 11/6/24.
//

import SwiftUI
import SwiftData

struct KittyView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Kitty.name) private var kittens: [Kitty]
    
    @State private var isPresentingAddKittyAlert = false
    @State private var newKittyName = ""
    @State private var newKittyAge = ""
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(kittens) { kitty in
                    HStack {
                        Text(kitty.emoji)
                            .font(.largeTitle)
                        VStack(alignment: .leading) {
                            Text(kitty.name)
                                .font(.headline)
                            Text("Age: \(kitty.age)")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteKitties)
            }
            .navigationTitle("Kitties")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        isPresentingAddKittyAlert = true
                    }) {
                        Label("Add Kitty", systemImage: "plus")
                    }
                }
            }
            .alert("Add New Kitty", isPresented: $isPresentingAddKittyAlert) {
                TextField("Name", text: $newKittyName)
                    .disableAutocorrection(true)
                TextField("Age", text: $newKittyAge)
                    .disableAutocorrection(true)
                    .keyboardType(.numberPad)
                Button("Add", action: addKitty)
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Enter the name and age of the new kitty.")
            }
            .onAppear {
                KittySamples.shared.populateSampleDataIfNeeded(
                    modelContext: modelContext)
            }
        } detail: {
            Text("Select a kitty")
        }
    }
    
    private func addKitty() {
        guard !newKittyName.isEmpty, let age = Int(newKittyAge) else { return }
        let newKitty = Kitty(
            name: newKittyName,
            age: age,
            emoji: catEmojis.randomElement()!)
        modelContext.insert(newKitty)
        newKittyName = ""
        newKittyAge = ""
    }

    private func deleteKitties(at offsets: IndexSet) {
        for index in offsets {
            let kitty = kittens[index]
            modelContext.delete(kitty)
        }
    }
}

#Preview {
    let container = KittySamples.shared.createPreviewModelContainer()
    return KittyView()
        .modelContainer(container)
}
