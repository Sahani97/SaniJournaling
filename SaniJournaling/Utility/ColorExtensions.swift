import SwiftUI

extension Color {
    func toHexString() -> String {
        if let components = UIColor(self).cgColor.components {
            let red = Int(components[0] * 255)
            let green = Int(components[1] * 255)
            let blue = Int(components[2] * 255)
            return String(format: "#%02X%02X%02X", red, green, blue)
        }
        return "#000000" // Fallback-Farbe (Schwarz)
    }

    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: 1.0)
    }
}
