//
//  StretchyCollectionViewHeaderLayout.swift
//  Terra
//
//  Created by Anthony Gonzalez on 8/29/20.
//  Copyright © 2020 Antnee. All rights reserved.
//

import UIKit

final class StretchyCollectionViewHeaderLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach( { (attributes) in
            
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader && attributes.indexPath.section == 0 {
                
                guard let collectionView = collectionView else { return }
                
                let contentOffsetY = collectionView.contentOffset.y
                
                guard contentOffsetY < 0  else { return }
                
                let width = collectionView.frame.width
                
                let height = attributes.frame.height - contentOffsetY
                
                // header
                attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
            }
        } )
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
