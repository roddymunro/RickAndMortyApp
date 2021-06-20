//
//  EpisodeCell.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    static let reuseId = "EpisodeCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(episode: Episode) {
        textLabel?.text = episode.name
        detailTextLabel?.text = "\(episode.episode) - \(episode.airDate)"
    }
}
