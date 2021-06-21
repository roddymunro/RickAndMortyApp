//
//  Episode.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

struct Episode: FetchableItem {
    
    var id: Int
    var name: String
    let airDate: String
    let episode: String
    let characters: [String]
    var url: String
    var created: String
    
    static func == (lhs: Episode, rhs: Episode) -> Bool {
        lhs.id == rhs.id
    }
}
