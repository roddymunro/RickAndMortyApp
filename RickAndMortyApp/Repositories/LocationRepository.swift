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
    private(set) var locations: [Location] = []
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
    
    public func fetchLocations() {
        if nextPageAvailable {
            api.getLocations(page: nextPage) { result in
                switch result {
                    case .success(let response):
                        self.paginationInfo = response.info
                        self.locations.append(contentsOf: response.results)
                        self.nextPage += 1
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
    
}
