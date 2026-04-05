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
            Label {
                if caffeineManager.isActive, let remaining = caffeineManager.remainingTime {
                    Text(remaining)
                }
            } icon: {
                Image("MenuBarIcon")
                    .renderingMode(.template)
            }
        }
        .menuBarExtraStyle(.window)
    }
}
