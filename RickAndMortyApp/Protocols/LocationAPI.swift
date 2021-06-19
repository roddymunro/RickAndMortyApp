//
//  LocationAPI.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

protocol LocationAPI {
    
    func getLocations(page: Int, _ completion: @escaping (Result<PaginatedResponse<Location>, Error>) -> Void)
    func getLocation(id: Int, _ completion: @escaping (Result<Location, Error>) -> Void)
    
}
