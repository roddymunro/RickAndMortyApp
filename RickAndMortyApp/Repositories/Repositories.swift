//
//  Repositories.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-20.
//

import Foundation

final class Repositories {
    
    private(set) var character: CharacterRepository
    private(set) var episode: EpisodeRepository
    private(set) var location: LocationRepository
    
    init() {
        self.character = CharacterRepository()
        self.episode = EpisodeRepository()
        self.location = LocationRepository()
    }
}
