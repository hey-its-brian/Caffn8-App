//
//  Caffn8App.swift
//  Caffn8
//
//  Created by Brian Meyer on 4/5/26.
//

import SwiftUI

@main
struct Caffn8App: App {
    @StateObject private var caffeineManager = CaffeineManager()

    init() {
        if NSEvent.modifierFlags.contains(.option) {
            UserDefaults.standard.set(true, forKey: "isIconVisible")
        }
    }

    var body: some Scene {
        MenuBarExtra {
            MenuBarView()
                .environmentObject(caffeineManager)
        } label: {
            // A Label only renders its icon in the menu bar, so use an HStack to show the countdown too
            HStack(spacing: 4) {
                Image("MenuBarIcon")
                    .renderingMode(.template)
                if caffeineManager.isActive, let remaining = caffeineManager.remainingTime {
                    Text(remaining)
                        .monospacedDigit()
                }
            }
        }
        .menuBarExtraStyle(.window)
    }
}
