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
    private(set) var episodes: [Episode] = []
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
                        self.episodes.append(contentsOf: response.results)
                        self.nextPage += 1
                        onFetch()
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
    
    public func refresh(onFetch: @escaping ()->()) {
        nextPage = 1
        episodes.removeAll()
        paginationInfo = nil
        fetchEpisodes(onFetch: onFetch)
    }
}
