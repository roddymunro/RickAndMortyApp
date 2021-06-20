//
//  LocationAPI.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

protocol LocationAPI {
    
    func getLocations(page: Int, _ completion: @escaping (Result<Data, Error>) -> Void)
    func getLocation(using urlString: String, _ completion: @escaping (Result<Data, Error>) -> Void)
    
}
