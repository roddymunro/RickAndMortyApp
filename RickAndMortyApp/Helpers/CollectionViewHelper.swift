//
//  CollectionViewHelper.swift
//  RickAndMortyApp
//
//  Created by Roddy Munro on 2021-06-18.
//

import UIKit

enum CollectionViewHelper {
    
    static func createCharacterCollectionViewFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let numberOfItemsPerRow: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 5 : 3
        let padding: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 16 : 12
        let availableWidth = view.bounds.width - (padding * (numberOfItemsPerRow + 1))
        let itemWidth = availableWidth / numberOfItemsPerRow
        
        let flowlayout = UICollectionViewFlowLayout()
        
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 32)
        
        return flowlayout
    }
    
}
