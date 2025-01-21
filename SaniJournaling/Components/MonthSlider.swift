import SwiftUI

struct MonthSlider: View {
    @Binding var currentMonthIndex: Int

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<13, id: \.self) { index in
                Button(action: {
                    withAnimation {
                        currentMonthIndex = index
                    }
                }) {
                    VStack {
                        Circle()
                            .fill(currentMonthIndex == index ? Color.black : Color.gray.opacity(0.3))
                            .frame(width: 12, height: 12)
                        
                        Text(index < 12 ? DateConstants.monthNames[index].prefix(1) : "Y")
                            .font(.caption2)
                            .foregroundColor(currentMonthIndex == index ? .black : .gray)
                    }
                }
            }
        }
    }
}
