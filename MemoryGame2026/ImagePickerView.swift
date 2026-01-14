//
//  ImagePickerView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-13.
//
import SwiftUI

struct ImagePickerView: View {
    @Binding var index: Int
    let images: [String]
    var body: some View {
        HStack() {
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
                .frame(maxWidth: 100, maxHeight: 100)
                .padding(.vertical, 20)
                .padding(.horizontal, 70)
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
    }
    
    private func showPrevious() {
        index = index == 0 ? images.count - 1 : index - 1
    }

    private func showNext() {
        index = (index + 1) % images.count
    }
}

