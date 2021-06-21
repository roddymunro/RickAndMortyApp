//
//  Repository.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-21.
//

import Foundation

final class Repository<T: FetchableItem> {
    
    private let api: API
    
    private(set) var paginationInfo: Info?
    private(set) var data: [T] = []
    private(set) var nextPage: Int = 1
    
    private(set) var filter: Filter
    
    // Is there another page to fetch or not
    public var nextPageAvailable: Bool {
        if let pageCount = paginationInfo?.pages {
            return nextPage <= pageCount
        } else {
            return true
        }
    }
    
    init(api: API, filter: Filter, nextPage: Int = 1) {
        self.api = api
        self.filter = filter
        self.nextPage = nextPage
    }
    
    // Fetches the next page of results, whether a filter is applied or not
    public func fetchNextPage(_ completion: @escaping (Result<String, Error>) -> Void) {
        if nextPageAvailable {
            if filter.isActive {
                api.filter(by: filter.filterString, page: nextPage) { result in
                    self.handleFetchResult(result) { result in
                        completion(result)
                    }
                }
            } else {
                api.fetchNextPage(page: nextPage) { result in
                    self.handleFetchResult(result) { result in
                        completion(result)
                    }
                }
            }
        } else {
            completion(.success("No Pages Left"))
        }
    }
    
    // Fetches a single item using the URL provided
    public func fetch(by urlString: String, _ completion: @escaping (Result<T, Error>) -> Void) {
        if let item = getByUrl(urlString: urlString) {
            completion(.success(item))
        } else {
            api.fetch(using: urlString) { result in
                switch result {
                    case .success(let data):
                        do {
                            let item: T = try JSONManager.shared.decode(data: data)
                            self.data.append(item)
                            self.data.sort(by: { $0.id < $1.id })
                            completion(.success(item))
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
    
    // Method to handle fetching a paginated response, to reduce code repetition
    private func handleFetchResult(_ result: Result<Data, Error>, _ completion: @escaping (Result<String, Error>) -> Void) {
        switch result {
            case .success(let data):
                do {
                    let response: PaginatedResponse<T> = try JSONManager.shared.decode(data: data)
                    self.paginationInfo = response.info
                    response.results.forEach { item in
                        if !self.data.contains(item) {
                            self.data.append(item)
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
    
    // Called when a user wants to refresh the contents of the screen they are on
    public func refresh(_ completion: @escaping (Result<String, Error>) -> Void) {
        nextPage = 1
        data.removeAll()
        paginationInfo = nil
        fetchNextPage { result in
            completion(result)
        }
    }
    
    // Gets an item from the data array using the URL provided
    private func getByUrl(urlString: String) -> T? {
        data.first { $0.url == urlString }
    }
    
}
