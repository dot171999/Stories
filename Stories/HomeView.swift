//
//  ContentView.swift
//  Stories
//
//  Created by Aryan Sharma on 19/09/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                StoriesView()
                    .frame(height: 220)
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
