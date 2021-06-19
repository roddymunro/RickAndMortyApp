//
//  APIError.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

enum APIError: Error {
    case invalidResponse
    case decodingError
    case invalidUrl
}
