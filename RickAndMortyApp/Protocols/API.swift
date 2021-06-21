//
//  API.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-21.
//

import Foundation

protocol API {
    
    var endpoint: String { get set }
    
    func fetchNextPage(page: Int, _ completion: @escaping (Result<Data, Error>) -> Void)
    func fetch(using urlString: String, _ completion: @escaping (Result<Data, Error>) -> Void)
    func filter(by filterString: String, page: Int, _ completion: @escaping (Result<Data, Error>) -> Void)
}
