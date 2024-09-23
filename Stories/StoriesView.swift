//
//  StoriesView.swift
//  Stories
//
//  Created by Aryan Sharma on 20/09/24.
//

import SwiftUI

struct StoriesView: View {
    
    @State var stories: Stories = []
    
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    
    private let networkManager = NetworkManager.shared
    private var vm = ViewModel()
    
    init() {
        UIScrollView.appearance().bounces = true
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 0) {
                ForEach (stories) { story in
                    ZStack {
                       RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: vm.allContentSeen(for: story) ? 0 : 3)
                            .frame(width: 87, height: 147)
                            .foregroundStyle(vm.allContentSeen(for: story) ? .linearGradient(colors: [.gray], startPoint: .top, endPoint: .bottom) : .linearGradient(colors: [.blue, .purple, .blue], startPoint: .top, endPoint: .bottom))
                            
                        NavigationLink(value: story) {
                            Image(story.image)
                                .frame(width: 80, height: 140)
                                .background(.black)
                                .clipShape(.rect(cornerRadius: 15))
                        }
                    }
                    .padding(.leading)
                }
            }
            .padding(.trailing)
        }
        .scrollBounceBehavior(.basedOnSize, axes: .horizontal)
        .task {
            let (fetchedStories, fetchedError) =   await NetworkManager.shared.getStories()
            
            if let stories = fetchedStories {
                self.stories = stories
            } else if let error = fetchedError {
                errorMessage = error
                showError.toggle()
            }
        }
        .alert(errorMessage, isPresented: $showError) {
            Button("OK", role: .cancel) {}
        }
        .navigationDestination(for: Story.self) { story in
            StoriesContentView(for: story, in: $stories)
        }
    }
}

extension StoriesView {
    class ViewModel {
        
        func allContentSeen(for story: Story) -> Bool {
            var allSeen: Bool = true
            for content in story.contents {
                if !content.seen {
                    allSeen = false
                    break
                }
            }
            return allSeen
        }
    }
}

#Preview {
    StoriesView()
}
