//
//  CharacterCell.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import UIKit

class CharacterCell: UICollectionViewCell {
    
    static let reuseId = "CharacterCell"
    
    let imageView = CharacterImageView(frame: .zero)
    let nameLabel = TitleLabel(textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(imageView, nameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    public func set(character: Character) {
        imageView.downloadImage(from: character.image)
        nameLabel.text = character.name
    }
}
