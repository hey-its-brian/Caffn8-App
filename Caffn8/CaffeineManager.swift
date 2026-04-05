//
//  CaffeineManager.swift
//  Caffn8
//
//  Created by Brian Meyer on 4/5/26.
//
import Foundation
import Combine

class CaffeineManager: ObservableObject {
    @Published var isActive = false
    @Published var remainingTime: String? = nil

    private var caffeineProcess: Process?
    private var timer: Timer?
    private var endTime: Date?

    func start(duration: TimeInterval?) {
        stop()

        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/caffeinate")

        if let duration = duration {
            process.arguments = ["-di", "-t", String(Int(duration))]
            endTime = Date().addingTimeInterval(duration)
            startCountdown()
            remainingTime = formatTime(duration)
        } else {
            process.arguments = ["-di"]
            endTime = nil
            remainingTime = "∞"
        }

        try? process.run()
        caffeineProcess = process
        isActive = true
    }

    func stop() {
        caffeineProcess?.terminate()
        caffeineProcess = nil
        timer?.invalidate()
        timer = nil
        isActive = false
        remainingTime = nil
        endTime = nil
    }

    func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            guard let end = self.endTime else { return }
            let remaining = end.timeIntervalSinceNow
            if remaining <= 0 {
                self.stop()
            } else {
                self.remainingTime = self.formatTime(remaining)
            }
        }
    }

    private func formatTime(_ seconds: TimeInterval) -> String {
        let hours = Int(seconds) / 3600
        let minutes = (Int(seconds) % 3600) / 60
        let secs = Int(seconds) % 60
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, secs)
        } else {
            return String(format: "%d:%02d", minutes, secs)
        }
    }
}
