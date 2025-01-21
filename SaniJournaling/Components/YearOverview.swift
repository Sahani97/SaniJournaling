import SwiftUI

struct YearOverview: View {
    @Binding var dayColors: [Int: Color]
    private let daysInMonths = DateConstants.daysInMonths
    private let monthNames = DateConstants.monthNames

    var legendItems: [String: Color]
    var orderedKeys: [String]

    var body: some View {
        ScrollView {
            HStack(alignment: .top) {
                // Tagesnummern (links)
                VStack(alignment: .trailing, spacing: 2) {
                    Spacer().frame(height: 20)
                    ForEach(1...31, id: \.self) { day in
                        Text("\(day)")
                            .font(.caption)
                            .frame(width: 20, height: 15, alignment: .center)
                            .foregroundColor(.black)
                    }
                }
                .padding(.trailing, 5)

                // Monatsübersicht (Mitte)
                VStack(alignment: .leading, spacing: 2) {
                    // Monatsbuchstaben
                    HStack(spacing: 2) {
                        ForEach(0..<12, id: \.self) { monthIndex in
                            Text(monthNames[monthIndex].prefix(1))
                                .font(.caption)
                                .bold()
                                .frame(width: 15, alignment: .center)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.bottom, 5)

                    // Tagesansicht pro Monat
                    ForEach(1...31, id: \.self) { day in
                        HStack(spacing: 2) {
                            ForEach(0..<12, id: \.self) { monthIndex in
                                if day <= daysInMonths[monthIndex] {
                                    let dayOfYear = calculateDayOfYear(month: monthIndex, day: day)
                                    Rectangle()
                                        .fill(dayColors[dayOfYear] ?? Color.gray.opacity(0.3))
                                        .frame(width: 15, height: 15)
                                        .cornerRadius(3)
                                } else {
                                    Rectangle()
                                        .fill(Color.clear)
                                        .frame(width: 15, height: 15)
                                }
                            }
                        }
                    }
                }

                Spacer()

                // Legende (rechts)
                VStack(alignment: .leading, spacing: 15) {
                    Text("Legend")
                        .font(.headline)
                        .padding(.bottom, 5)

                    LegendView(
                        legendItems: legendItems,
                        orderedKeys: orderedKeys,
                        columns: 1
                    )
                }
                .padding(.leading, 5)
            }
            .padding()
        }
    }

    private func calculateDayOfYear(month: Int, day: Int) -> Int {
        return daysInMonths.prefix(month).reduce(0, +) + day
    }
}
