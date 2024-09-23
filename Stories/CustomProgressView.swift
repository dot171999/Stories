//
//  ProgressView.swift
//  Stories
//
//  Created by Aryan Sharma on 21/09/24.
//

import SwiftUI

struct CustomProgressView: View {
    @State var numberOfSegments: Int
    @Binding var currentSegment: Int
    @Binding var progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack(spacing: 4) {
                    ForEach(0..<numberOfSegments, id: \.self) { index in
                        ProgressView(value: index < currentSegment ? 1.0 : (index == currentSegment ? progress : 0.0))
                            .progressViewStyle(LinearProgressViewStyle())
                    }
                }
                .padding()
            }
            
        }
    }
}
#Preview {
    CustomProgressView(numberOfSegments: 4, currentSegment: .constant(2), progress: .constant(0))
}
