//
//  LocationRepository.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import Foundation

final class LocationRepository {
    
    private let api: LocationAPI
    
    private var paginationInfo: Info?
    private(set) var data: [Location] = []
    private var nextPage: Int = 1
    
    public var nextPageAvailable: Bool {
        if let pageCount = paginationInfo?.pages {
            return nextPage <= pageCount
        } else {
            return true
        }
    }
    
    init(api: LocationAPI = AppLocationAPI()) {
        self.api = api
    }
    
    public func fetchLocations(onFetch: @escaping ()->()) {
        if nextPageAvailable {
            api.getLocations(page: nextPage) { result in
                switch result {
                    case .success(let response):
                        self.paginationInfo = response.info
                        response.results.forEach { location in
                            if !self.data.contains(location) {
                                self.data.append(location)
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
    
    public func fetchLocation(by urlString: String, _ completion: @escaping (Result<Location, Error>) -> Void) {
        if let location = getLocationByUrl(urlString: urlString) {
            completion(.success(location))
        } else {
            api.getLocation(using: urlString) { result in
                switch result {
                    case .success(let location):
                        self.data.append(location)
                        self.data.sort(by: { $0.id < $1.id })
                        completion(.success(location))
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
        fetchLocations(onFetch: onFetch)
    }
    
    private func getLocationByUrl(urlString: String) -> Location? {
        data.first { $0.url == urlString }
    }
}
