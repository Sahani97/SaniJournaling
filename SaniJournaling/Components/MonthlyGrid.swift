import SwiftUI

struct MonthlyGrid: View {
    let monthIndex: Int
    @Binding var dayColors: [Int: Color]
    private let daysInMonths = DateConstants.daysInMonths

    var legendItems: [String: Color]
    var orderedKeys: [String]
    var legendColumns: Int
    var imageName: String
    var onYearOverview: () -> Void

    var body: some View {
        VStack {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 10) {
                ForEach(1...daysInMonths[monthIndex], id: \.self) { day in
                    let dayOfYear = calculateDayOfYear(month: monthIndex, day: day)
                    Rectangle()
                        .fill(dayColors[dayOfYear] ?? .gray.opacity(0.3))
                        .frame(height: 40)
                        .cornerRadius(5)
                        .overlay(
                            Text("\(day)")
                                .font(.caption)
                                .foregroundColor(.black)
                        )
                }
            }
            .padding()

            // Legende und Bild
            VStack {
                LegendView(
                    legendItems: legendItems,
                    orderedKeys: orderedKeys,
                    columns: legendColumns
                )
                .padding(.horizontal)

                HStack {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .padding(.leading)

                    Spacer()

                    Button(action: onYearOverview) {
                        Text("Year Overview")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(8)
                            .padding(.trailing)
                    }
                }
            }
        }
    }

    private func calculateDayOfYear(month: Int, day: Int) -> Int {
        return daysInMonths.prefix(month).reduce(0, +) + day
    }
}
