//
//  LocationCell.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit

class LocationCell: UITableViewCell {
    
    static let reuseId = "LocationCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func set(location: Location) {
        textLabel?.text = location.name
        detailTextLabel?.text = "\(location.type) - \(location.dimension)"
    }
}
