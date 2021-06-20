//
//  CharacterRepositoryTests.swift
//  RickAndMortyAppTests
//
//  Created by Roddy Munro on 2021-06-20.
//

import XCTest

class CharacterRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchCharactersFirstPage() throws {
        let repository = CharacterRepository(api: MockCharacterAPI())
        
        repository.fetchCharacters { result in
            switch result {
                case .success:
                    XCTAssert(repository.data.count == 20)
                    XCTAssert(repository.nextPageAvailable)
                    XCTAssert(repository.nextPage == 2)
                case .failure:
                    XCTFail("Unexpected failure when fetching all characters")
            }
        }
    }
    
    func testFetchCharactersInvalidPage() throws {
        let repository = CharacterRepository(api: MockCharacterAPI(), nextPage: -1)
        
        repository.fetchCharacters { result in
            switch result {
                case .success:
                    XCTFail("Unexpected success with invalid page")
                case .failure(let error):
                    XCTAssert(error as? APIError == .invalidUrl)
                    XCTAssert(repository.data.count == 0)
            }
        }
    }
    
    func testFetchCharacterSuccess() throws {
        let repository = CharacterRepository(api: MockCharacterAPI())
        let characterUrl = "https://rickandmortyapi.com/api/character/1"
        
        repository.fetchCharacter(by: characterUrl) { result in
            switch result {
                case .success(let character):
                    XCTAssert(character.url == characterUrl)
                    XCTAssert(repository.data.count == 1)
                case .failure:
                    XCTFail("Unexpected failure when fetching character")
            }
        }
    }
    
    func testFetchCharactersInvalidUrl() throws {
        let repository = CharacterRepository(api: MockCharacterAPI())
        let characterUrl = "BADURL*()#42"
        
        repository.fetchCharacter(by: characterUrl) { result in
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
