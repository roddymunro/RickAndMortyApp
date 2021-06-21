//
//  FetchableItem.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-21.
//

import Foundation

protocol FetchableItem: Codable, Identifiable, Hashable {
    
    var id: Int { get set }
    var name: String { get set }
    var url: String { get set }
    var created: String { get set }
    
}
