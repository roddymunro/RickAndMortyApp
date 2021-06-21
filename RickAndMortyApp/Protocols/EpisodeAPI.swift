//
//  EpisodeAPI.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

protocol EpisodeAPI {
    
    func getEpisodes(page: Int, _ completion: @escaping (Result<Data, Error>) -> Void)
    func getEpisode(using urlString: String, _ completion: @escaping (Result<Data, Error>) -> Void)
    func filterEpisodes(by filterString: String, page: Int, _ completion: @escaping (Result<Data, Error>) -> Void)
    
}
