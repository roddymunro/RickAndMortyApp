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
    
    public var isActive: Bool {
        !name.isEmpty || !type.isEmpty || !dimension.isEmpty
    }
    
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
    
    public func reset() {
        self.name = ""
        self.type = ""
        self.dimension = ""
    }
}
