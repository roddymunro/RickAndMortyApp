//
//  UIView+Ext.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import UIKit

extension UIView {
    
    func addSubview(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func addSubview(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
    
    func pinToEdges(of superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor)
        ])
    }
}
