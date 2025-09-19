import UIKit

enum Theme: String {
    case original
    case vibrant
}

class ThemeManager {
    static let shared = ThemeManager()
    private let themeKey = "selectedTheme"
    static let themeChangedNotification = NSNotification.Name("themeChanged")

    var currentTheme: Theme = .original {
        didSet {
            UserDefaults.standard.set(currentTheme.rawValue, forKey: themeKey)
            NotificationCenter.default.post(name: ThemeManager.themeChangedNotification, object: nil)
        }
    }

    private init() {
        if let savedThemeName = UserDefaults.standard.string(forKey: themeKey),
           let savedTheme = Theme(rawValue: savedThemeName) {
            self.currentTheme = savedTheme
        }
    }
}
