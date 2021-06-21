//
//  LocationRepository.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

final class LocationRepository {
    
    private let api: LocationAPI
    
    private(set) var paginationInfo: Info?
    private(set) var data: [Location] = []
    private(set) var nextPage: Int = 1
    
    private(set) var filter = LocationFilter()
    
    public var nextPageAvailable: Bool {
        if let pageCount = paginationInfo?.pages {
            return nextPage <= pageCount
        } else {
            return true
        }
    }
    
    init(api: LocationAPI = AppLocationAPI(), nextPage: Int = 1) {
        self.api = api
        self.nextPage = nextPage
    }
    
    public func fetchLocations(_ completion: @escaping (Result<String, Error>) -> Void) {
        if nextPageAvailable {
            if filter.isActive {
                api.filterLocations(by: filter.filterString, page: nextPage) { result in
                    self.handleFetchResult(result) { result in
                        completion(result)
                    }
                }
            } else {
                api.getLocations(page: nextPage) { result in
                    self.handleFetchResult(result) { result in
                        completion(result)
                    }
                }
            }
        } else {
            completion(.success("No Pages Left"))
        }
    }
    
    public func fetchLocation(by urlString: String, _ completion: @escaping (Result<Location, Error>) -> Void) {
        if let location = getLocationByUrl(urlString: urlString) {
            completion(.success(location))
        } else {
            api.getLocation(using: urlString) { result in
                switch result {
                    case .success(let data):
                        do {
                            let location: Location = try JSONManager.shared.decode(data: data)
                            self.data.append(location)
                            self.data.sort(by: { $0.id < $1.id })
                            completion(.success(location))
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
    
    private func handleFetchResult(_ result: Result<Data, Error>, _ completion: @escaping (Result<String, Error>) -> Void) {
        switch result {
            case .success(let data):
                do {
                    let response: PaginatedResponse<Location> = try JSONManager.shared.decode(data: data)
                    self.paginationInfo = response.info
                    response.results.forEach { location in
                        if !self.data.contains(location) {
                            self.data.append(location)
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
    
    public func refresh(_ completion: @escaping (Result<String, Error>) -> Void) {
        nextPage = 1
        data.removeAll()
        paginationInfo = nil
        fetchLocations { result in
            completion(result)
        }
    }
    
    private func getLocationByUrl(urlString: String) -> Location? {
        data.first { $0.url == urlString }
    }
}
