//
//  WImagePickerView.swift
//  MemoryGame2026
//
//  Created by Negin Saatchi on 2026-02-09.
//

import SwiftUI

struct ImagePickerView: View {
    @Binding var selectedImageIndex: Int
    let images : [String]
    
    var body: some View {
        HStack{
            Button(action: showPrevious) {
                Image(systemName: "arrowtriangle.left.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            }
            .accessibilityLabel("Previous image")
            .accessibilityIdentifier("PrevImage")
            .buttonStyle(.plain)
            .foregroundStyle(.white)
            .accessibilityValue(String(selectedImageIndex))
            
            Spacer()
            
            Image(systemName: images.indices.contains(selectedImageIndex) ? images[selectedImageIndex] : images.first ?? "questionmark")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80, height: 80)
                .accessibilityLabel(images.indices.contains(selectedImageIndex) ? images[selectedImageIndex] : (images.first ?? "Image"))
                .accessibilityIdentifier("targetImage")
                .accessibilityValue(images.indices.contains(selectedImageIndex) ? images[selectedImageIndex] : (images.first ?? "Image"))
            
            Spacer()

            Button(action: showNext) {
                Image(systemName: "arrowtriangle.right.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            }
            .accessibilityLabel("Next image")
            .accessibilityIdentifier("NextImage")
            .accessibilityValue(String(selectedImageIndex))
            .buttonStyle(.plain)
            .foregroundStyle(.white)
        }
    }
    
    private func showPrevious() {
        selectedImageIndex = selectedImageIndex == 0 ? images.count - 1 : selectedImageIndex - 1
    }
    
    private func showNext() {
        selectedImageIndex = (selectedImageIndex + 1) % images.count
    }
}


#Preview("ImagePickerView") {
    @Previewable @State var idx = 0
    ImagePickerView(selectedImageIndex: .constant(idx), images: ["sun.max", "cloud.sun", "cloud.rain"])
}
