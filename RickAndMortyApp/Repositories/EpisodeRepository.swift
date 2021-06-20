//
//  EpisodeRepository.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

final class EpisodeRepository {
    
    private let api: EpisodeAPI
    
    private(set) var paginationInfo: Info?
    private(set) var data: [Episode] = []
    private(set) var nextPage: Int = 1
    
    public var nextPageAvailable: Bool {
        if let pageCount = paginationInfo?.pages {
            return nextPage <= pageCount
        } else {
            return true
        }
    }
    
    init(api: EpisodeAPI = AppEpisodeAPI(), nextPage: Int = 1) {
        self.api = api
        self.nextPage = nextPage
    }
    
    public func fetchEpisodes(_ completion: @escaping (Result<String, Error>) -> Void) {
        if nextPageAvailable {
            api.getEpisodes(page: nextPage) { result in
                switch result {
                    case .success(let data):
                        do {
                            let response: PaginatedResponse<Episode> = try JSONManager.shared.decode(data: data)
                            self.paginationInfo = response.info
                            response.results.forEach { episode in
                                if !self.data.contains(episode) {
                                    self.data.append(episode)
                                }
                            }
                            self.data.sort(by: { $0.id < $1.id })
                            self.nextPage += 1
                            completion(.success("Success"))
                        } catch {
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        completion(.failure(error))
                }
            }
        } else {
            completion(.success("No Pages Left"))
        }
    }
    
    public func fetchEpisode(by urlString: String, _ completion: @escaping (Result<Episode, Error>) -> Void) {
        if let episode = getEpisodeByUrl(urlString: urlString) {
            completion(.success(episode))
        } else {
            api.getEpisode(using: urlString) { result in
                switch result {
                    case .success(let data):
                        do {
                            let episode: Episode = try JSONManager.shared.decode(data: data)
                            self.data.append(episode)
                            self.data.sort(by: { $0.id < $1.id })
                            completion(.success(episode))
                        } catch {
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        completion(.failure(error))
                }
            }
        }
    }
    
    public func refresh(_ completion: @escaping (Result<String, Error>) -> Void) {
        nextPage = 1
        data.removeAll()
        paginationInfo = nil
        fetchEpisodes { result in
            completion(result)
        }
    }
    
    private func getEpisodeByUrl(urlString: String) -> Episode? {
        data.first { $0.url == urlString }
    }
}
