//
//  ImagePickerView.swift
//  MemoryGame2026
//
//  Created by Alireza Mirzaahmadkermanshahi on 2026-01-13.
//
import SwiftUI

/// A compact control for cycling through a collection of SF Symbols by index.
///
/// ImagePickerView displays a central symbol with previous/next buttons on each side.
/// It binds the current selection via `index` and reads available symbol names from `images`.
struct ImagePickerView: View {
    /// The currently selected image index bound to an external source.
    @Binding var index: Int
    /// The list of SF Symbol names to display and navigate through.
    let images: [String]
    /// Renders a horizontal layout with previous/next controls and the selected symbol.
    /// Includes accessibility labels, identifiers, and values for UI testing and VoiceOver.
    var body: some View {
        HStack(spacing: 70) {
            // Previous button
            Button(action: showPrevious) {
                Image(systemName: "arrowtriangle.left.fill")
                    .resizable()
                    .symbolRenderingMode(.hierarchical)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
            }
            .accessibilityLabel("Previous image")
            .accessibilityIdentifier("PrevImage")
            .buttonStyle(.plain)
            .foregroundStyle(.tint)
            .accessibilityValue(String(index))

            // Selected image
            Image(systemName: images.indices.contains(index) ? images[index] : images.first ?? "questionmark")
                .resizable()
                .symbolRenderingMode(.monochrome)
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.primary)
                .frame(width: 150, height: 150)
                .accessibilityLabel(images.indices.contains(index) ? images[index] : (images.first ?? "Image"))
                .accessibilityIdentifier("targetImage")
                .accessibilityValue(images.indices.contains(index) ? images[index] : (images.first ?? "Image"))

            // Next button
            Button(action: showNext) {
                Image(systemName: "arrowtriangle.right.fill")
                    .resizable()
                    .symbolRenderingMode(.hierarchical)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 44, height: 44)
            }
            .accessibilityLabel("Next image")
            .accessibilityIdentifier("NextImage")
            .accessibilityValue(String(index))
            .buttonStyle(.plain)
            .foregroundStyle(.tint)
        }
    }
    
    /// Moves selection to the previous symbol, wrapping to the end when at the first item.
    private func showPrevious() {
        index = index == 0 ? images.count - 1 : index - 1
    }

    /// Moves selection to the next symbol, wrapping to the beginning at the end of the list.
    private func showNext() {
        index = (index + 1) % images.count
    }
}

// Preview showcasing navigation through three SF Symbols using a bound index.
#Preview("ImagePickerView") {
    @Previewable @State var idx = 0
    return ImagePickerView(index: .constant(idx), images: ["sun.max", "cloud.sun", "cloud.rain"])
}

