//
//  Filter.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-21.
//

import Foundation

protocol Filter {
    
    var isActive: Bool { get }
    var filterString: String { get }
    
    func reset()
}
