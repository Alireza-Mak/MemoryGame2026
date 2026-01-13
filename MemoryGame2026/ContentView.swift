//
//  ContentView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-08.
//

import SwiftUI

struct ContentView: View {
    private let images = ["sun.max", "cloud.sun", "cloud.rain"]
    @State private var index: Int = 0

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "arrowtriangle.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 44, height: 44)
                .foregroundStyle(.tint)
                .accessibilityLabel("Previous image")
                .onTapGesture { showPrevious() }

            Image(systemName: images[index])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.primary)
                .frame(maxWidth: 200, maxHeight: 200)
                .padding(24)
                .accessibilityLabel(images[index])

            Image(systemName: "arrowtriangle.right")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 44, height: 44)
                .foregroundStyle(.tint)
                .accessibilityLabel("Next image")
                .onTapGesture { showNext() }
        }
        .padding()

        Text(images[index])
            .font(.headline)
            .padding(.bottom)
    }

    private func showPrevious() {
        index = index == 0 ? images.count - 1 : index - 1
    }

    private func showNext() {
        index = (index + 1) % images.count
    }
}

#Preview {
    ContentView()
}
