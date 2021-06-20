//
//  CollectionViewHelper.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import UIKit

enum CollectionViewHelper {
    
    static func createCharacterCollectionViewFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let padding: CGFloat = 12
        let availableWidth = view.bounds.width - (padding * 4)
        let itemWidth = availableWidth / 3
        
        let flowlayout = UICollectionViewFlowLayout()
        
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 32)
        
        return flowlayout
    }
    
}
