//
//  Location.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

struct Location: FetchableItem {
    
    var id: Int
    var name: String
    let type: String
    let dimension: String
    let residents: [String]
    var url: String
    var created: String

    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

struct LocationReference: Codable {
    let name: String
    let url: String
}

extension LocationReference: Hashable {
    static func == (lhs: LocationReference, rhs: LocationReference) -> Bool {
        lhs.url == rhs.url
    }
}
