//
//  NetworkImageView.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import UIKit

class CharacterImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        image = UIImage(named: "characterImagePlaceholder")
        layer.masksToBounds = false
        layer.cornerRadius = frame.height / 2
        contentMode = .scaleAspectFill
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func downloadImage(from urlString: String) {
        NetworkManager.shared.downloadImage(from: urlString) { [weak self] image in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.image = image
                self.layer.masksToBounds = false
                self.layer.cornerRadius = self.frame.height / 2
                self.contentMode = .scaleAspectFill
                self.clipsToBounds = true
            }
        }
    }
}
