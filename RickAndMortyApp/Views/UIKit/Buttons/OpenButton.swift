//
//  OpenButton.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit

class OpenButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        setTitle(NSLocalizedString(title, comment: "Text for \(title) button"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        titleLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.systemBlue, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
