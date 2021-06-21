//
//  Repositories.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-20.
//

import Foundation

final class Repositories {
    
    private(set) var character: Repository<Character>
    private(set) var episode: Repository<Episode>
    private(set) var location: Repository<Location>
    
    init() {
        self.character = .init(api: AppAPI(endpoint: "character"), filter: CharacterFilter())
        self.episode = .init(api: AppAPI(endpoint: "episode"), filter: EpisodeFilter())
        self.location = .init(api: AppAPI(endpoint: "location"), filter: LocationFilter())
    }
}
