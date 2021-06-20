//
//  DetailView.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit

class DetailView: UIView {
    
    let titleLabel = TitleLabel(textAlignment: .left)
    let detailLabel = TitleLabel(textAlignment: .right)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        titleLabel.text = NSLocalizedString(title, comment: "Text for \(title) label")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel, detailLabel)
        configureLabels()
    }
    
    private func configureLabels() {
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        detailLabel.numberOfLines = 0
        detailLabel.textColor = .secondaryLabel
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: detailLabel.leadingAnchor, constant: -padding),
            
            detailLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            detailLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            detailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
    
    public func set(detail: String) {
        detailLabel.text = detail
    }
}
