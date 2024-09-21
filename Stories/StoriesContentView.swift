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
    
    init(for story: Story, in stories: Binding<Stories>) {
        self.story = story
        self._stories = stories
    }
    
    var body: some View {
        Text(story.name)
    }
}

#Preview {

    let (fetchedStories, _) = NetworkManager.shared.getStories1()
    
    return StoriesContentView(for: fetchedStories![0], in: .constant(fetchedStories!))
}
