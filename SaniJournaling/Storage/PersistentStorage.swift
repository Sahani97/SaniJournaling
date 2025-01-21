import SwiftUI

class PersistentStorage {
    private static func fileURL(forKey key: String) -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(key).json")
    }

    static func save(dayColors: [Int: Color], forKey key: String) {
        let hexColorMap = dayColors.mapValues { $0.toHexString() } // Farben in Hex konvertieren

        do {
            let jsonData = try JSONEncoder().encode(hexColorMap)
            let url = fileURL(forKey: key)
            try jsonData.write(to: url)
            print("Colors for \(key) saved successfully to \(url)")
        } catch {
            print("Error saving colors for \(key): \(error)")
        }
    }

    static func load(forKey key: String) -> [Int: Color] {
        do {
            let url = fileURL(forKey: key)
            let jsonData = try Data(contentsOf: url)
            let savedData = try JSONDecoder().decode([String: String].self, from: jsonData)

            var dayColors: [Int: Color] = [:]
            for (key, value) in savedData {
                if let day = Int(key), let color = Color(hex: value) { // `Int(key)` sicherstellen
                    dayColors[day] = color
                }
            }
            return dayColors
        } catch {
            print("Error loading colors for \(key): \(error)")
            return [:]
        }
    }
}
