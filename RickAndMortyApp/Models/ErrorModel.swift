//
//  ErrorModel.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

struct ErrorModel {
    let title: String
    let error: Error
    
    public var message: String {
        error.localizedDescription
    }
}
