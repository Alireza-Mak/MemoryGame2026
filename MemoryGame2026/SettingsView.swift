//
//  SettingsView.swift
//  MemoryGame2026
//
//  Created by  on 2026-01-13.
//
import SwiftUI

struct SettingsView : View{
 
    @Binding var bouns:Bool
    @Binding var index:Int
    @Binding var step:Int
    let images: [String]
    
    var body: some View {
        
        
        VStack(spacing: 20){
            ImagePickerView(
                index: $index,
                images: images
            )
            Stepper(value:$step, in:5...10){Text("\(step) Rows/Cols")}
            Toggle("Bouns", isOn: $bouns)
        }
        .padding(30)
        
    }
}
