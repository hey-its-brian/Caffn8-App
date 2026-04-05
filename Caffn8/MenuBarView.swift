//
//  MenuBarView.swift
//  Caffn8
//
//  Created by Brian Meyer on 4/5/26.
//

import SwiftUI

struct MenuBarView: View {
    @EnvironmentObject var manager: CaffeineManager
    
    let presets: [(label: String, seconds: TimeInterval?)] = [
        ("30 minutes", 1800),
        ("1 hour", 3600),
        ("2 hours", 7200),
        ("4 hours", 14400),
        ("Indefinitely", nil)
    ]
    @State private var customHours: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Caffn8")
                .font(.headline)
                .padding(.top, 8)
                .padding(.horizontal)
            
            if manager.isActive {
                HStack {
                    Image(systemName: "cup.and.heat.waves.fill")
                        .foregroundColor(.brown)
                    Text(manager.remainingTime.map { "Active — \($0) remaining" } ?? "Active — running indefinitely")
                        .font(.subheadline)
                }
                .padding(.horizontal)

                Divider()

                Button("Stop") {
                    manager.stop()
                }
                .padding(.horizontal)
            } else {
                Text("Keep awake for:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                ForEach(presets, id: \.label) { preset in
                    Button(preset.label) {
                        manager.start(duration: preset.seconds)
                    }
                    .padding(.horizontal)
                }
                Divider()
                
                HStack {
                    TextField("Custom hours", text: $customHours)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                    Button("Start") {
                        if let hours = Double(customHours), hours > 0 {
                            manager.start(duration: hours * 3600)
                            customHours = ""
                        }
                    }
                    .disabled(Double(customHours) == nil)
                }
                .padding(.horizontal)
            }
            Divider()
                }

            Button("Quit Caffn8") {
                manager.stop()
                NSApplication.shared.terminate(nil)
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            .frame(width: 240)
        }

    private func showReappearAlert() {
        let alert = NSAlert()
        alert.messageText = "Menu bar icon will be hidden"
        alert.informativeText = "To get it back, relaunch Caffn8 while holding Option (⌥)."
        alert.alertStyle = .informational
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
}


