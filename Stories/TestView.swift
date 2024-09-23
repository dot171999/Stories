//
//  TestView.swift
//  Stories
//
//  Created by Aryan Sharma on 22/09/24.
//

import SwiftUI


struct ContentView1: View {
    @State private var tappedSide: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.clear // Ensure the ZStack covers the full screen
                Text("Tap on the sides")
                    .font(.largeTitle)
                    //.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray.opacity(0.2))
                    .contentShape(Rectangle())
                    
            }
            .contentShape(Rectangle())
            .frame(width: geometry.size.width, height: geometry.size.height)
            .onTapGesture(coordinateSpace: .global) { location in
                if location.x < geometry.size.width / 2 {
                    tappedSide = "Left side tapped"
                } else {
                    tappedSide = "Right side tapped"
                }
            }
            .overlay(
                Text(tappedSide)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 5),
                alignment: .bottom // Position it as needed
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ContentView1()
}
