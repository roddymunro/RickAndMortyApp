//
//  EpisodeRepository.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

final class EpisodeRepository {
    
    private let api: EpisodeAPI
    
    private var paginationInfo: Info?
    private(set) var data: [Episode] = []
    private var nextPage: Int = 1
    
    public var nextPageAvailable: Bool {
        if let pageCount = paginationInfo?.pages {
            return nextPage <= pageCount
        } else {
            return true
        }
    }
    
    init(api: EpisodeAPI = AppEpisodeAPI()) {
        self.api = api
    }
    
    public func fetchEpisodes(onFetch: @escaping ()->()) {
        if nextPageAvailable {
            api.getEpisodes(page: nextPage) { result in
                switch result {
                    case .success(let response):
                        self.paginationInfo = response.info
                        response.results.forEach { episode in
                            if !self.data.contains(episode) {
                                self.data.append(episode)
                            }
                        }
                        self.data.sort(by: { $0.id < $1.id })
                        self.nextPage += 1
                        onFetch()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
    
    public func fetchEpisode(by urlString: String, _ completion: @escaping (Result<Episode, Error>) -> Void) {
        if let episode = getEpisodeByUrl(urlString: urlString) {
            completion(.success(episode))
        } else {
            api.getEpisode(using: urlString) { result in
                switch result {
                    case .success(let episode):
                        self.data.append(episode)
                        self.data.sort(by: { $0.id < $1.id })
                        completion(.success(episode))
                    case .failure(let error):
                        print(error.localizedDescription)
                        completion(.failure(error))
                }
            }
        }
    }
    
    public func refresh(onFetch: @escaping ()->()) {
        nextPage = 1
        data.removeAll()
        paginationInfo = nil
        fetchEpisodes(onFetch: onFetch)
    }
    
    private func getEpisodeByUrl(urlString: String) -> Episode? {
        data.first { $0.url == urlString }
    }
}
