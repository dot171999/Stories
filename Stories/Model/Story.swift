//
//  Story.swift
//  Stories
//
//  Created by Aryan Sharma on 20/09/24.
//

import Foundation

typealias Stories = [Story]

struct Story: Codable, Identifiable, Hashable {
    
    let id: Int
    let name: String
    let image: String
    let contents: [Content]
}

struct Content: Codable, Hashable {
    let type: ContentType
    let id: Int
    let url: String

    var seen: Bool 
    
    enum CodingKeys: String, CodingKey {
        case type
        case id
        case url
    }
    
    enum ContentType: String, Codable {
        case video
        case image
    }
    
    init(type: ContentType, id: Int, url: String, seen: Bool) {
        self.type = type
        self.id = id
        self.url = url
        self.seen = seen
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(ContentType.self, forKey: .type)
        id = try container.decode(Int.self, forKey: .id)
        url = try container.decode(String.self, forKey: .url)
        seen = false 
    }
}


