//
//  CharacterFilter.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-21.
//

import SwiftUI

final class CharacterFilter: ObservableObject {
    
    @Published var name: String = ""
    @Published var status: String = ""
    @Published var species: String = ""
    @Published var type: String = ""
    @Published var gender: String = ""
    
    public var isActive: Bool {
        !name.isEmpty || !status.isEmpty || !species.isEmpty || !type.isEmpty || !gender.isEmpty
    }
    
    public var filterString: String {
        var filterComponents: [String] = []
        if !name.isEmpty {
            filterComponents.append("name=\(name)")
        }
        if !status.isEmpty {
            filterComponents.append("status=\(status)")
        }
        if !species.isEmpty {
            filterComponents.append("species=\(species)")
        }
        if !type.isEmpty {
            filterComponents.append("type=\(type)")
        }
        if !gender.isEmpty {
            filterComponents.append("gender=\(gender)")
        }
        
        return filterComponents.joined(separator: "&")
    }
    
    init() {}
    
    let statusOptions: [String] = ["alive", "dead", "unknown"]
    let genderOptions: [String] = ["female", "male", "genderless", "unknown"]
    
    public func reset() {
        self.name = ""
        self.status = ""
        self.species = ""
        self.type = ""
        self.gender = ""
    }
}
