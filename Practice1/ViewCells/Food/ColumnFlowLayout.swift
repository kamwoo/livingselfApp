//
//  ColumnFlowLayout.swift
//  Practice1
//
//  Created by wooyeong kam on 2021/10/16.
//

import Foundation
import UIKit

class ColumnFlowLayout: UICollectionViewFlowLayout {
    private let minColumnWidth: CGFloat = UIScreen.main.bounds.width / 8
    private let cellHeight: CGFloat = UIScreen.main.bounds.height / 5
    
    private var deletingIndexPaths = [IndexPath]()
    private var insetingIndexPaths = [IndexPath]()
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else {
            return
        }
        let availableWidth = collectionView.bounds.inset(by: collectionView.layoutMargins).width
        let maxNumColumns = Int(availableWidth/minColumnWidth)
        let cellWidth = (availableWidth/CGFloat(maxNumColumns)).rounded(.down)
        itemSize = CGSize(width: cellWidth, height: cellWidth)
        sectionInset = UIEdgeInsets(top: minimumInteritemSpacing, left: 0, bottom: 0, right: 0)
        sectionInsetReference = .fromContentInset
    }
    
    override func prepare(forCollectionViewUpdates updateItems: [UICollectionViewUpdateItem]) {
        super.prepare()
        for update in updateItems {
            switch update.updateAction {
            case .delete:
                guard let indexPath = update.indexPathBeforeUpdate else {
                    return
                }
                deletingIndexPaths.append(indexPath)
            case .insert:
                guard let indexPath = update.indexPathAfterUpdate else {
                    return
                }
                insetingIndexPaths.append(indexPath)
            default:
                break
            }
        }
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.finalLayoutAttributesForDisappearingItem(at: itemIndexPath) else {
            return nil
        }
        if deletingIndexPaths.contains(itemIndexPath){
            attributes.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            attributes.alpha = 0
            attributes.zIndex = 0
        }
        return attributes
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath) else {
            return nil
        }
        if insetingIndexPaths.contains(itemIndexPath){
            attributes.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            attributes.alpha = 0
            attributes.zIndex = 0
        }
        return attributes
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        deletingIndexPaths.removeAll()
        insetingIndexPaths.removeAll()
    }
}
