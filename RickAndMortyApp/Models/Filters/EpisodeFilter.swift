//
//  EpisodeFilter.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-21.
//

import SwiftUI

final class EpisodeFilter: ObservableObject, Filter {
    
    @Published var name: String = ""
    @Published var episode: String = ""
    
    public var isActive: Bool {
        !name.isEmpty || !episode.isEmpty
    }
    
    public var filterString: String {
        var filterComponents: [String] = []
        if !name.isEmpty {
            filterComponents.append("name=\(name)")
        }
        if !episode.isEmpty {
            filterComponents.append("episode=\(episode)")
        }
        
        return filterComponents.joined(separator: "&")
    }
    
    init() {}
    
    public func reset() {
        self.name = ""
        self.episode = ""
    }
}
