//
//  ContentView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-08.
//

import SwiftUI

struct ContentView: View {
    private let images: [String]  = ["sun.max", "cloud.sun", "cloud.rain"]
    @AppStorage("index") private var index: Int = 0
    @AppStorage("step") private var step: Int = 7
    @AppStorage("bouns") private var bouns: Bool = true
    @State private var showingSettings: Bool = false
    

    var body: some View {
        NavigationStack {
            Group{
                if showingSettings {
                    SettingsView( bouns: $bouns, index: $index, step: $step, images: images)
                }else{
                    GameView(name: images[index])
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        showingSettings.toggle()
                    }label: {
                        Image(systemName: showingSettings ? "house" : "gear")
                            .resizable()
                            .frame(width: 40, height: 35)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
