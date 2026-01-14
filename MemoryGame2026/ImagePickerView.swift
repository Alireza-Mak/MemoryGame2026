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
        HStack(spacing: 70) {
            Button(action: showPrevious) {
                Image(systemName: "arrowtriangle.left.fill")
                    .resizable()
                    .symbolRenderingMode(.hierarchical)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
            }
            .accessibilityLabel("Previous image")
            .buttonStyle(.plain)
            .foregroundStyle(.tint)

            Image(systemName: images.indices.contains(index) ? images[index] : images.first ?? "questionmark")
                .resizable()
                .symbolRenderingMode(.monochrome)
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.primary)
                .frame(width: 150, height: 150)
                .accessibilityLabel(images.indices.contains(index) ? images[index] : (images.first ?? "Image"))

            Button(action: showNext) {
                Image(systemName: "arrowtriangle.right.fill")
                    .resizable()
                    .symbolRenderingMode(.hierarchical)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
            }
            .accessibilityLabel("Next image")
            .buttonStyle(.plain)
            .foregroundStyle(.tint)
        }
    }
    
    private func showPrevious() {
        index = index == 0 ? images.count - 1 : index - 1
    }

    private func showNext() {
        index = (index + 1) % images.count
    }
}

#Preview("ImagePickerView") {
    @State var idx = 0
    return ImagePickerView(index: .constant(idx), images: ["sun.max", "cloud.sun", "cloud.rain"])
}
