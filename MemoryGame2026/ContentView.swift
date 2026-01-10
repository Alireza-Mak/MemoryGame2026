//
//  ContentView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-08.
//

import SwiftUI

struct ContentView: View {
    @State private var img = ["sun.max","cloud.sun","cloud.rain"]
    @State private var stage:Int = 0
    @State private var selectedPhoto: String = ""
    var body: some View {
        HStack {
            Image(systemName: "arrowtriangle.left")
                .resizable()
                .foregroundStyle(.tint)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .onTapGesture {
                    stage = stage == 0 ? img.count - 1 : stage - 1
                }

            Image(systemName: img[stage])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.black)
                .padding(25)
            
            Image(systemName: "arrowtriangle.right")
                .resizable()
                .foregroundStyle(.tint)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .onTapGesture {
                    stage = (stage + 1) % img.count
                }
        }
        .padding()
        HStack{
           Text(img[stage])
        }
    }
}

#Preview {
    ContentView()
}
