//
//  StoryView.swift
//  Stories
//
//  Created by Aryan Sharma on 22/09/24.
//

import SwiftUI

struct StoryView: View {
    @State var story: Story
    @State var contentIndex: Int = 0
    @State private var progress: CGFloat = 0.0
    @State private var timer: Timer?
    @State var isVisible: Bool = false
    @State var firstLaunch: Bool = false
    
    var firstLaunchStoryId: Int
    
    var content: Content {
        get {
            story.contents[contentIndex]
        }
    }
    
    init(for story: Story, _ firstLaunchStoryId: Int ) {
        self.story = story
        self.firstLaunchStoryId = firstLaunchStoryId
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if content.type == .image {
                    Image(content.url)
                        .resizable()
                        .scaledToFit()
                        .containerRelativeFrame(.horizontal)
                    
                } else {
                    Text("Video")
                }
                
                VStack {
                    CustomProgressView(numberOfSegments: story.contents.count, currentSegment: $contentIndex, progress: $progress)
                        .frame(height: 40)
                        .background(Color(red: 1, green: 1, blue: 1, opacity: 0.5))
                    Text("Story No = \(story.id), Content No = \(content.id)")
                    Spacer()
                }
            }
            .contentShape(Rectangle())
            .onChange(of: geometry.frame(in: .global)) { oldValue, newValue in
                checkVisibility(geometry: newValue)
            }
            .onTapGesture(coordinateSpace: .global) { tapLocation in
                let screenWidth = geometry.size.width
                if tapLocation.x < screenWidth / 2 {
                    // left
                    let temp = contentIndex - 1
                    let _ = print("left", contentIndex)
                    if temp > 0 {
                        contentIndex -= 1
                        startProgress()
                    } else if temp <= 0 {
                        contentIndex = 0
                        startProgress()
                    }
                } else {
                    // right
                    let temp = contentIndex + 1
                    if temp < story.contents.count {
                        contentIndex += 1
                        startProgress()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipped()
        .onAppear {
            let _ = print("onAppear - ", story.id )
            for (index, content) in story.contents.enumerated() {
                if !content.seen {
                    contentIndex = index
                    break
                }
            }
            
            if firstLaunchStoryId == story.id {
                startProgress()
                firstLaunch = false
            }
        }
    }
}

#Preview {
    let (fetchedStories, _) = NetworkManager.shared.getStories1()
    return StoryView(for: fetchedStories![1], 2)
}

extension StoryView {
    func startProgress() {
        timer?.invalidate()
        progress = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            withAnimation {
                progress += 1 / 3
                if progress >= 1.0 {
                    let temp = contentIndex + 1
                    if temp < story.contents.count {
                        contentIndex += 1
                        progress = 0.0
                    }
                    else {
                        timer?.invalidate()
                        timer = nil
                    }
                }
            }
        }
    }
    
    private func checkVisibility(geometry: CGRect) {
        let screenWidth = UIScreen.main.bounds.width
        
        if geometry.minX >= 0 && geometry.maxX <= screenWidth {
            if !isVisible {
                isVisible = true
                startProgress()
            }
        } else {
            if isVisible {
                isVisible = false
            }
        }
    }
}
