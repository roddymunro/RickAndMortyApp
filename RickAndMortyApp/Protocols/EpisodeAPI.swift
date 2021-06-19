//
//  EpisodeAPI.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

protocol EpisodeAPI {
    
    func getEpisodes(page: Int, _ completion: @escaping (Result<PaginatedResponse<Episode>, Error>) -> Void)
    func getEpisode(id: Int, _ completion: @escaping (Result<Episode, Error>) -> Void)
    
}
