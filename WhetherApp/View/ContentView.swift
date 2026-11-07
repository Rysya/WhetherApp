//
//  ContentView.swift
//  WhetherApp
//
//  Created by Мария Александрова on 10.09.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            WeatherView()
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
