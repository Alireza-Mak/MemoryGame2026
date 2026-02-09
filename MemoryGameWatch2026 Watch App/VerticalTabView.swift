import SwiftUI

struct VerticalTabView: View {
    @State private var selectedImageIndex: Int = 0
    @State private var bonus = true
    private let images: [String] = ["sun.max", "cloud.sun", "cloud.rain", "cloud"]
    var body: some View {
        TabView {
            GameView(bonus: bonus, selectedImage: images[selectedImageIndex])
                .id("game-\(bonus)-\(selectedImageIndex)")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tag(0)
            SettingsView(bonus: $bonus, selectedImageIndex: $selectedImageIndex, images: images)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .tag(1)
        }
        .tabViewStyle(.verticalPage)
        
    }
}

#Preview("Vertical Tab") {
    VerticalTabView()
}
