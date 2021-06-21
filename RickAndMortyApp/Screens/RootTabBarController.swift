//
//  RootTabBarController.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit

class RootTabBarController: UITabBarController {
    
    private var repositories: Repositories = .init()
    
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
        let charactersViewController = CharacterListViewController(repositories: repositories)
        
        let iconConfig = UIImage.SymbolConfiguration(scale: .large)
        let characterIcon = UIImage(systemName: "person.3", withConfiguration: iconConfig)
        
        charactersViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString(
                "navigationTitle.characters",
                comment: "The navigation title for the Characters screen."
            ),
            image: characterIcon,
            tag: 0
        )
        return UINavigationController(rootViewController: charactersViewController)
    }
    
    private func createEpisodesNavigationController() -> UINavigationController {
        let episodesViewController = EpisodeListViewController(repositories: repositories)
        
        let iconConfig = UIImage.SymbolConfiguration(scale: .large)
        let episodeIcon = UIImage(systemName: "play.rectangle", withConfiguration: iconConfig)
        
        episodesViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString(
                "navigationTitle.episodes",
                comment: "The navigation title for the Episodes screen."
            ),
            image: episodeIcon,
            tag: 1
        )
        return UINavigationController(rootViewController: episodesViewController)
    }
    
    private func createLocationsNavigationController() -> UINavigationController {
        let locationsViewController = LocationListViewController(repositories: repositories)
        
        let iconConfig = UIImage.SymbolConfiguration(scale: .large)
        let locationIcon = UIImage(systemName: "globe", withConfiguration: iconConfig)
        
        locationsViewController.tabBarItem = UITabBarItem(
            title: NSLocalizedString(
                "navigationTitle.locations",
                comment: "The navigation title for the Locations screen."
            ),
            image: locationIcon,
            tag: 1
        )
        return UINavigationController(rootViewController: locationsViewController)
    }
}
