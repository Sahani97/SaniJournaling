import SwiftUI

struct LegendView: View {
    var legendItems: [String: Color]
    var orderedKeys: [String]
    var columns: Int // Anzahl der Spalten

    var body: some View {
        if columns == 1 {
            // Einspaltige Legende
            VStack(alignment: .leading, spacing: 10) {
                ForEach(orderedKeys, id: \.self) { key in
                    if let color = legendItems[key] {
                        HStack {
                            Rectangle()
                                .fill(color)
                                .frame(width: 20, height: 20)
                                .cornerRadius(5)
                            Text(key)
                                .font(.caption)
                        }
                    }
                }
            }
        } else {
            // Mehrspaltige Legende
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: columns), alignment: .leading) {
                ForEach(orderedKeys, id: \.self) { key in
                    if let color = legendItems[key] {
                        HStack {
                            Rectangle()
                                .fill(color)
                                .frame(width: 20, height: 20)
                                .cornerRadius(5)
                            Text(key)
                                .font(.caption)
                        }
                    }
                }
            }
        }
    }
}
