import SwiftUI

struct ColorConstants {
    static let moodColors: [String: Color] = [
        "Good": .yellow,
        "Normal": .green,
        "Stressed": .red,
        "Anxious": .orange,
        "Sad": .blue,
        "Angry": Color(red: 0.7, green: 0, blue: 0),
        "Tired": .teal.opacity(0.6),
        "Meh": .purple.opacity(0.6),
        "Better": .purple,
        "Failed to write anything": .gray
    ]
    static let sleepColors: [String: Color] = [
        "9+ hours": Color(red: 0.1, green: 0.7, blue: 0.8),
        "8 hours": Color(red: 0.1, green: 0.7, blue: 0.6),
        "7 hours": .green,
        "6 hours": .green.opacity(0.7),
        "5 hours": .orange,
        "4 hours": .red.opacity(0.7),
        "3 hours or less": .red,
        "Failed to write anything": .gray
    ]
    static let gymColors: [String: Color] = [
        "Gym": .blue,
        "Other kind of Exercise": .teal,
        "Restday": Color(red: 0.95, green: 0.95, blue: 0.95),
        "Too Lazy": .red,
        "No Time": .yellow,
        "Failed to write anything": .gray
    ]
    static let readingColors: [String: Color] = [
        "0": .red.opacity(0.8),
        "0-20 Pages": Color(red: 1.0, green: 0.5, blue: 0.4),
        "21-40 Pages": Color(red: 1.0, green: 0.6, blue: 0.6),
        "41-60 Pages": Color(red: 1.0, green: 0.6, blue: 0.7),
        "61-80 Pages": Color(red: 1.0, green: 0.8, blue: 1.0),
        "81-100 Pages": Color(red: 0.8, green: 0.7, blue: 1.0),
        "101+ Pages": Color(red: 0.5, green: 0.4, blue: 0.6),
        "Failed to write anything": .gray
        
        
    ]
    
    // Zentrale Definition der orderedKeys für jeden Screen-Typ
    static let orderedKeys: [String: [String]] = [
        "Mood": [
            "Good", "Normal", "Stressed", "Anxious",
            "Sad", "Angry", "Tired", "Meh", "Better", "Failed to write anything"
        ],
        "Sleep": [
            "9+ hours", "8 hours", "7 hours", "6 hours", "5 hours",
            "4 hours", "3 hours or less", "Failed to write anything"
        ],
        "Gym": [
            "Gym", "Other kind of Exercise", "Restday",
            "Too Lazy", "No Time", "Failed to write anything"
        ],
        "Reading": [
            "101+ Pages", "81-100 Pages", "61-80 Pages",
            "41-60 Pages", "21-40 Pages", "0-20 Pages", "0", "Failed to write anything"
        ]
    ]

    // Methode für die Farbauswahl
    static func color(for option: String, in screenType: String) -> Color? {
        switch screenType {
        case "Mood":
            return moodColors[option]
        case "Sleep":
            return sleepColors[option]
        case "Gym":
            return gymColors[option]
        case "Reading":
            return readingColors[option]
        default:
            return nil
        }
    }
}
