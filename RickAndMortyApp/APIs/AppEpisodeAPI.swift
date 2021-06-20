//
//  AppEpisodeAPI.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

final class AppEpisodeAPI: EpisodeAPI {
    func getEpisodes(page: Int, _ completion: @escaping (Result<PaginatedResponse<Episode>, Error>) -> Void) {
        NetworkManager.shared.getDataFrom(endpoint: "episode/?page=\(page)") { result in
            switch result {
                case .success(let data):
                    do {
                        let paginatedResults: PaginatedResponse<Episode> = try JSONManager.shared.decode(data: data)
                        completion(.success(paginatedResults))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getEpisode(using urlString: String, _ completion: @escaping (Result<Episode, Error>) -> Void) {
        NetworkManager.shared.getDataUsing(urlString: urlString) { result in
            switch result {
                case .success(let data):
                    do {
                        let episode: Episode = try JSONManager.shared.decode(data: data)
                        completion(.success(episode))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    
}
