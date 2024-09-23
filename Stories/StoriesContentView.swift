//
//  StoryView.swift
//  Stories
//
//  Created by Aryan Sharma on 21/09/24.
//

import SwiftUI

struct StoriesContentView: View {
    @State var story: Story
    @Binding var stories: Stories
    var firstLaunchStoryId: Int
    
    init(for story: Story, in stories: Binding<Stories>) {
        self.story = story
        self._stories = stories
        self.firstLaunchStoryId = story.id
    }
    
    var body: some View {
        ScrollViewReader { value in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 0) {
                    ForEach (stories) { story in
                        StoryView(for: story, firstLaunchStoryId)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .containerRelativeFrame(.horizontal)
                        .id(story.id)
                        .scrollTransition(.animated, axis: .horizontal) { content, phase in
                            content
                                .opacity(phase.isIdentity ? 1.0 : 0.8)
                                .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                        }
                    }
                }
            }
            .scrollTargetBehavior(.paging)
            .onAppear {
                value.scrollTo(story.id)
            }
        }
    }
}

#Preview {

    let (fetchedStories, _) = NetworkManager.shared.getStories1()
    
    return StoriesContentView(for: fetchedStories![0], in: .constant(fetchedStories!))
}

