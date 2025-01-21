import SwiftUI

struct AddEntryView: View {
    var screenType: String // Typ des Screens ("Mood", "Sleep", etc.)
    @Binding var dayColors: [Int: Color] // Verweis auf die Farben des Screens
    @State private var selectedDate = Date()
    @State private var selectedOption = ""
    @Environment(\.presentationMode) var presentationMode // Zum Schließen des Fensters

    // Minimal- und Maximaldatum für das Jahr 2025
    private let calendar = Calendar.current
    private var minDate: Date {
        calendar.date(from: DateComponents(year: 2025, month: 1, day: 1))!
    }
    private var maxDate: Date {
        calendar.date(from: DateComponents(year: 2025, month: 12, day: 31))!
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Add Entry for \(screenType)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .multilineTextAlignment(.center)

            // Kalender-Auswahl (nur für 2025)
            DatePicker("Select Date", selection: $selectedDate, in: minDate...maxDate, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxHeight: 350)
                .padding(.horizontal, 20)

            // Optionen basierend auf dem Screen-Typ
            Picker("\(screenType)", selection: $selectedOption) {
                ForEach(sortedOptionsForScreen(screenType), id: \.self) { option in
                    Text(option)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 150)

            // Speichern-Button
            Button(action: {
                saveEntry()
                PersistentStorage.save(dayColors: dayColors, forKey: "\(screenType)Colors2025") // Speichern in der JSON-Datei
                presentationMode.wrappedValue.dismiss() // Fenster schließen
            }) {
                Text("Save")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
            }
        }
        .onAppear {
            // Standarddatum initialisieren (heute oder 2025)
            let today = Date()
            if calendar.component(.year, from: today) == 2025 {
                selectedDate = today
            } else {
                selectedDate = minDate
            }

            // Setze eine Standardoption (erste in der Liste)
            if let firstOption = sortedOptionsForScreen(screenType).first {
                selectedOption = firstOption
            }
        }
        .padding()
    }

    private func saveEntry() {
        let month = calendar.component(.month, from: selectedDate) - 1
        let day = calendar.component(.day, from: selectedDate)
        let dayOfYear = calculateDayOfYear(month: month, day: day)

        // Farbe basierend auf der Auswahl und dem Typ holen
        if let color = ColorConstants.color(for: selectedOption, in: screenType) {
            dayColors[dayOfYear] = color
        } else {
            print("Fehler: Keine Farbe für '\(selectedOption)' in '\(screenType)' gefunden.")
        }
    }

    private func calculateDayOfYear(month: Int, day: Int) -> Int {
        let daysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        return daysInMonths.prefix(month).reduce(0, +) + day
    }

    private func sortedOptionsForScreen(_ type: String) -> [String] {
        // Holt die zentral definierten orderedKeys aus ColorConstants
        return ColorConstants.orderedKeys[type] ?? []
    }
}
