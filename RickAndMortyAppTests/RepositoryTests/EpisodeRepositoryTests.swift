//
//  EpisodeRepositoryTests.swift
//  RickAndMortyAppTests
//
//  Created by Roddy Munro on 2021-06-20.
//

import XCTest

class EpisodeRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchEpisodesFirstPage() throws {
        let repository = EpisodeRepository(api: MockEpisodeAPI())
        
        repository.fetchEpisodes { result in
            switch result {
                case .success:
                    XCTAssert(repository.data.count == 20)
                    XCTAssert(repository.nextPageAvailable)
                    XCTAssert(repository.nextPage == 2)
                case .failure:
                    XCTFail("Unexpected failure when fetching all episodes")
            }
        }
    }
    
    func testFetchEpisodesInvalidPage() throws {
        let repository = EpisodeRepository(api: MockEpisodeAPI(), nextPage: -1)
        
        repository.fetchEpisodes { result in
            switch result {
                case .success:
                    XCTFail("Unexpected success with invalid page")
                case .failure(let error):
                    XCTAssert(error as? APIError == .invalidUrl)
                    XCTAssert(repository.data.count == 0)
            }
        }
    }
    
    func testFetchEpisodeSuccess() throws {
        let repository = EpisodeRepository(api: MockEpisodeAPI())
        let episodeUrl = "https://rickandmortyapi.com/api/episode/1"
        
        repository.fetchEpisode(by: episodeUrl) { result in
            switch result {
                case .success(let episode):
                    XCTAssert(episode.url == episodeUrl)
                    XCTAssert(repository.data.count == 1)
                case .failure:
                    XCTFail("Unexpected failure when fetching episode")
            }
        }
    }
    
    func testFetchEpisodesInvalidUrl() throws {
        let repository = EpisodeRepository(api: MockEpisodeAPI())
        let episodeUrl = "BADURL*()#42"
        
        repository.fetchEpisode(by: episodeUrl) { result in
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
