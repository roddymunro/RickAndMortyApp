//
//  PaginatedResponse.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

struct PaginatedResponse<T: Codable>: Codable {
    
    let info: Info
    let results: [T]
}
