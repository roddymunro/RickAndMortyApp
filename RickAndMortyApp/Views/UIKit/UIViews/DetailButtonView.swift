//
//  DetailButtonView.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 19/06/2021.
//

import UIKit

class DetailButtonView: UIView {
    
    let titleLabel = TitleLabel(textAlignment: .left)
    let detailButton = UIButton()
    
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
        addSubview(titleLabel, detailButton)
        configureLabels()
    }
    
    private func configureLabels() {
        titleLabel.numberOfLines = 1
        titleLabel.textColor = .label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        detailButton.titleLabel?.numberOfLines = 0
        detailButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        detailButton.contentHorizontalAlignment = .right
        detailButton.setTitleColor(.systemBlue, for: .normal)
        detailButton.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: detailButton.leadingAnchor, constant: -padding),
            
            detailButton.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            detailButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            detailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
        ])
    }
    
    public func set(detail: String) {
        detailButton.setTitle(detail, for: .normal)
    }
}
