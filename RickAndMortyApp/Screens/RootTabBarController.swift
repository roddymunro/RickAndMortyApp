//
//  RootTabBarController.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    private var characterRepository: CharacterRepository = .init()
    private var episodeRepository: EpisodeRepository = .init()
    private var locationRepository: LocationRepository = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemBlue
        viewControllers = [
            createCharactersNavigationController(),
            createEpisodesNavigationController(),
            createLocationsNavigationController()
        ]
    }
    
    private func createCharactersNavigationController() -> UINavigationController {
        let charactersViewController = CharacterListViewController(repository: characterRepository)
        
        let iconConfig = UIImage.SymbolConfiguration(scale: .large)
        let characterIcon = UIImage(systemName: "person.3", withConfiguration: iconConfig)
        
        charactersViewController.tabBarItem = UITabBarItem(title: "Characters", image: characterIcon, tag: 0)
        return UINavigationController(rootViewController: charactersViewController)
    }
    
    private func createEpisodesNavigationController() -> UINavigationController {
        let episodesViewController = EpisodeListViewController(repository: episodeRepository)
        
        let iconConfig = UIImage.SymbolConfiguration(scale: .large)
        let episodeIcon = UIImage(systemName: "play.rectangle", withConfiguration: iconConfig)
        
        episodesViewController.tabBarItem = UITabBarItem(title: "Episodes", image: episodeIcon, tag: 1)
        return UINavigationController(rootViewController: episodesViewController)
    }
    
    private func createLocationsNavigationController() -> UINavigationController {
        let locationsViewController = LocationListViewController(repository: locationRepository)
        
        let iconConfig = UIImage.SymbolConfiguration(scale: .large)
        let locationIcon = UIImage(systemName: "globe", withConfiguration: iconConfig)
        
        locationsViewController.tabBarItem = UITabBarItem(title: "Locations", image: locationIcon, tag: 1)
        return UINavigationController(rootViewController: locationsViewController)
    }
}
