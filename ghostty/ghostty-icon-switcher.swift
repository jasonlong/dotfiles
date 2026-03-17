import AppKit
import Foundation

let configPath = NSString(string: "~/.config/ghostty/config").expandingTildeInPath
let darkIcon = "~/dev/ghostty-theme-icons/icons/poimandres/poimandres.icns"
let stormIcon = "~/dev/ghostty-theme-icons/icons/poimandres-storm/poimandres-storm.icns"

func isDarkMode() -> Bool {
    UserDefaults.standard.string(forKey: "AppleInterfaceStyle") == "Dark"
}

func switchIcon() {
    let icon = isDarkMode() ? darkIcon : stormIcon
    let pattern = "macos-custom-icon = .*/ghostty-theme-icons/.*"
    let replacement = "macos-custom-icon = \(icon)"

    let task = Process()
    task.executableURL = URL(fileURLWithPath: "/usr/bin/sed")
    task.arguments = ["-i", "", "s|\(pattern)|\(replacement)|", configPath]
    try? task.run()
    task.waitUntilExit()

    let reload = Process()
    reload.executableURL = URL(fileURLWithPath: "/usr/bin/osascript")
    reload.arguments = [
        "-e",
        "tell application \"System Events\" to tell process \"Ghostty\" to click menu item \"Reload Configuration\" of menu \"Ghostty\" of menu bar 1",
    ]
    try? reload.run()
}

// Switch on launch
switchIcon()

// Watch for theme changes
DistributedNotificationCenter.default().addObserver(
    forName: NSNotification.Name("AppleInterfaceThemeChangedNotification"),
    object: nil,
    queue: .main
) { _ in
    switchIcon()
}

RunLoop.main.run()
