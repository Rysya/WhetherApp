//
//  TemperatureRangeBar.swift
//  WhetherApp
//
//  Created by Мария Александрова on 15.09.2026.
//

import SwiftUI

struct TemperatureRangeBar: View {
    let minTemperature: Double
    let maxTemperature: Double

    // Общий диапазон шкалы
    let scaleMin: Double
    let scaleMax: Double

    var body: some View {
        GeometryReader { geometry in

            let width = geometry.size.width
            let start = normalizedPosition(minTemperature,
                                           width: width)
            let end = normalizedPosition(maxTemperature,
                                         width: width)
            // Ширина синей части
            let blueWidth = max(end - start, 0)
            ZStack(alignment: .leading) {
                // Серый фон
                Capsule()
                    .fill(.gray.opacity(0.35))
                // Температурный диапазон
                Capsule()
                    .fill(.blue.opacity(0.7))
                    .frame(width: blueWidth)
                    .offset(x: start)
            }
        }
        .frame(height: 40)
    }

    private func normalizedPosition(_ temperature: Double,
                                    width: CGFloat) -> CGFloat {
        let range = scaleMax - scaleMin
        guard range > 0 else { return 0 }
        let progress = (temperature - scaleMin) / range
        return width * CGFloat(progress)
    }
}

#Preview {
    TemperatureRangeBar(minTemperature: 3, maxTemperature: 4, scaleMin: -0.71, scaleMax: 4.38)
    TemperatureRangeBar(minTemperature: 18, maxTemperature: 26, scaleMin: 13, scaleMax: 30)
}
