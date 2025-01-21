import SwiftUI

struct SleepView: View {
    @Binding var dayColors: [Int: Color]

    private let daysInMonths = DateConstants.daysInMonths
    private let monthNames = DateConstants.monthNames

    @State private var currentMonthIndex = 0

    var body: some View {
        VStack {
            // Titel
            Text(currentMonthIndex < 12 ? "Sleep in \(monthNames[currentMonthIndex])" : "Sleep in 2025")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            // Horizontaler Slider für Monatsauswahl
            MonthSlider(currentMonthIndex: $currentMonthIndex)
                .padding(.vertical, 10)

            // TabView mit Monats- und Jahresansicht
            TabView(selection: $currentMonthIndex) {
                // Monatsansichten
                ForEach(0..<12, id: \.self) { monthIndex in
                    MonthlyGrid(
                        monthIndex: monthIndex,
                        dayColors: $dayColors,
                        legendItems: ColorConstants.sleepColors,
                        orderedKeys: ColorConstants.orderedKeys["Sleep"] ?? [],
                        legendColumns: 2,
                        imageName: "sleep",
                        onYearOverview: {
                            currentMonthIndex = 12 // Wechsel zur Jahresübersicht
                        }
                    )
                    .tag(monthIndex)
                }

                // Jahresübersicht
                YearOverview(
                    dayColors: $dayColors,
                    legendItems: ColorConstants.sleepColors,
                    orderedKeys: ColorConstants.orderedKeys["Sleep"] ?? []
                )
                .tag(12)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .onAppear {
            currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
        }
    }

    // Lokale Funktion zur Berechnung des Tages im Jahr
    private func calculateDayOfYear(month: Int, day: Int) -> Int {
        return daysInMonths.prefix(month).reduce(0, +) + day
    }
}
