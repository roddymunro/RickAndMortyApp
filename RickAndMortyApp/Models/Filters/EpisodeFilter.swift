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
    
    // Has a filter been set or not
    public var isActive: Bool {
        !name.isEmpty || !episode.isEmpty
    }
    
    // Generates the URL components required to apply a filter
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
    
    // Resets all filters
    public func reset() {
        self.name = ""
        self.episode = ""
    }
}
