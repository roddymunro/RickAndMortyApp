//
//  AppEpisodeAPI.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

final class AppEpisodeAPI: EpisodeAPI {
    func getEpisodes(page: Int, _ completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.getDataFrom(endpoint: "episode/?page=\(page)") { result in
            completion(result)
        }
    }
    
    func getEpisode(using urlString: String, _ completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.getDataUsing(urlString: urlString) { result in
            completion(result)
        }
    }
    
    func filterEpisodes(by filterString: String, page: Int, _ completion: @escaping (Result<Data, Error>) -> Void) {
        NetworkManager.shared.getDataFrom(endpoint: "episode/?page=\(page)&\(filterString)") { result in
            completion(result)
        }
    }
}
