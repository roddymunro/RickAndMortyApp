//
//  MockEpisodeAPI.swift
//  RickAndMortyAppTests
//
//  Created by Roddy Munro on 2021-06-20.
//

import Foundation
import UIKit

final class MockEpisodeAPI: EpisodeAPI {
    
    func getEpisodes(page: Int, _ completion: @escaping (Result<PaginatedResponse<Episode>, Error>) -> Void) {
        if page == -1 {
            completion(.failure(APIError.invalidUrl))
        } else {
            let info: Info = .init(count: 41, pages: 3, next: "https://rickandmortyapi.com/api/episode?page=\(page+1)", prev: nil)
            let episodes: [Episode] = Range(1...20).compactMap {
                .init(
                    id: $0,
                    name: "Pilot",
                    airDate: "December 2, 2013",
                    episode: "S01E01",
                    characters: [
                        "https://rickandmortyapi.com/api/character/1",
                        "https://rickandmortyapi.com/api/character/2"
                    ],
                    url: "https://rickandmortyapi.com/api/episode/1",
                    created: "2017-11-10T12:42:04.162Z"
                )
            }
            completion(.success(.init(info: info, results: episodes)))
        }
    }
    
    func getEpisode(using urlString: String, _ completion: @escaping (Result<Episode, Error>) -> Void) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            let episode: Episode = .init(
                id: 1,
                name: "Pilot",
                airDate: "December 2, 2013",
                episode: "S01E01",
                characters: [
                    "https://rickandmortyapi.com/api/character/1",
                    "https://rickandmortyapi.com/api/character/2"
                ],
                url: "https://rickandmortyapi.com/api/episode/1",
                created: "2017-11-10T12:42:04.162Z"
            )
            completion(.success(episode))
        } else {
            completion(.failure(APIError.invalidUrl))
        }
    }
    
}
