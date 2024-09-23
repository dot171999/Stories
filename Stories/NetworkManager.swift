//
//  NetworkManager.swift
//  Stories
//
//  Created by Aryan Sharma on 20/09/24.
//

import Foundation

class NetworkManager {
    
    enum ErrorDescriptionFor: String {
        case jsonfileNotFound = "Could not find the \"Sample.json\" file in the bundle."
        case  decodingError = "Failed to load or decode \"Sample.json\" file."
    }
    
    static let shared = NetworkManager()
    
    
    private init() {}
    
    
    // Making the function async to simulate API call.
    func getStories() async -> (Stories?, String?) {
        
        try? await Task.sleep(nanoseconds: 100000)
        
        guard let url = Bundle.main.url(forResource: "Sample", withExtension: "json") else {
            return (nil, ErrorDescriptionFor.jsonfileNotFound.rawValue)
        }
        
        do {
           
            let data = try Data(contentsOf: url)
            
           
            let decoder = JSONDecoder()
            let stories = try decoder.decode(Stories.self, from: data)
            
            return (stories, nil)
        } catch {
            print(error)
            return (nil, ErrorDescriptionFor.decodingError.rawValue)
        }
    }
    
    // Making the function async to simulate API call.
    func getStories1() -> (Stories?, String?) {
        
        
        
        guard let url = Bundle.main.url(forResource: "Sample", withExtension: "json") else {
            return (nil, ErrorDescriptionFor.jsonfileNotFound.rawValue)
        }
        
        do {
            
            let data = try Data(contentsOf: url)
            
            
            let decoder = JSONDecoder()
            let stories = try decoder.decode(Stories.self, from: data)
            
            return (stories, nil)
        } catch {
            print(error)
            return (nil, ErrorDescriptionFor.decodingError.rawValue)
        }
    }
}
