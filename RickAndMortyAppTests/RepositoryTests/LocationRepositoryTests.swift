//
//  LocationRepositoryTests.swift
//  RickAndMortyAppTests
//
//  Created by Roddy Munro on 2021-06-20.
//

import XCTest

class LocationRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchLocationsFirstPage() throws {
        let repository = Repository<Location>(api: MockAPI(endpoint: "locations"), filter: LocationFilter())
        
        repository.fetchNextPage { result in
            switch result {
                case .success:
                    XCTAssert(repository.data.count == 20)
                    XCTAssert(repository.nextPageAvailable)
                    XCTAssert(repository.nextPage == 2)
                case .failure:
                    XCTFail("Unexpected failure when fetching all locations")
            }
        }
    }
    
    func testFetchLocationsInvalidPage() throws {
        let repository = Repository<Location>(api: MockAPI(endpoint: "locations"), filter: LocationFilter(), nextPage: -1)
        
        repository.fetchNextPage { result in
            switch result {
                case .success:
                    XCTFail("Unexpected success with invalid page")
                case .failure(let error):
                    XCTAssert(error as? APIError == .invalidUrl)
                    XCTAssert(repository.data.count == 0)
            }
        }
    }
    
    func testFetchLocationSuccess() throws {
        let repository = Repository<Location>(api: MockAPI(endpoint: "location"), filter: LocationFilter())
        let locationUrl = "https://rickandmortyapi.com/api/location/1"
        
        repository.fetch(by: locationUrl) { result in
            switch result {
                case .success(let location):
                    XCTAssert(location.url == locationUrl)
                    XCTAssert(repository.data.count == 1)
                case .failure:
                    XCTFail("Unexpected failure when fetching location")
            }
        }
    }
    
    func testFetchLocationsInvalidUrl() throws {
        let repository = Repository<Location>(api: MockAPI(endpoint: "locations"), filter: LocationFilter())
        let locationUrl = "BADURL*()#42"
        
        repository.fetch(by: locationUrl) { result in
            switch result {
                case .success:
                    XCTFail("Unexpected success with invalid url")
                case .failure(let error):
                    XCTAssert(error as? APIError == .invalidUrl)
                    XCTAssert(repository.data.count == 0)
            }
        }
    }
}
