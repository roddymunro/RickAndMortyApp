//
//  LocationFilter.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-21.
//

import SwiftUI

final class LocationFilter: ObservableObject, Filter {
    
    @Published var name: String = ""
    @Published var type: String = ""
    @Published var dimension: String = ""
    
    // Has a filter been set or not
    public var isActive: Bool {
        !name.isEmpty || !type.isEmpty || !dimension.isEmpty
    }
    
    // Generates the URL components required to apply a filter
    public var filterString: String {
        var filterComponents: [String] = []
        if !name.isEmpty {
            filterComponents.append("name=\(name)")
        }
        if !type.isEmpty {
            filterComponents.append("type=\(type)")
        }
        if !dimension.isEmpty {
            filterComponents.append("dimension=\(dimension)")
        }
        
        return filterComponents.joined(separator: "&")
    }
    
    init() {}
    
    // Resets all filters
    public func reset() {
        self.name = ""
        self.type = ""
        self.dimension = ""
    }
}
