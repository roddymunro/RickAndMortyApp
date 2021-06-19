//
//  Info.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

struct Info: Codable {
    
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
