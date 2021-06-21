//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

struct Character: FetchableItem {
    
    var id: Int
    var name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationReference
    let location: LocationReference
    let image: String
    let episode: [String]
    var url: String
    var created: String
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
}
