//  CXYCollectionDataSource.swift
import Foundation
import UIKit

public typealias DidSelectCollectionHandler = (_ collectionView: UICollectionView, _ indexPath: IndexPath) -> Void

public class CXYCollectionDataSource : NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public var didSelect: DidSelectCollectionHandler?
}

extension CXYCollectionDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionView.c.numberOfSections()
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView.c.numberOfCellItems(atSection: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.c.reusableCell(atIndexPath: indexPath)
    }
}

extension CXYCollectionDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.c.sizeForCell(atIndexPath: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return collectionView.c.sizeForHeader(atSection: section)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return collectionView.c.sizeForFooter(atSection: section)
    }
}

extension CXYCollectionDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            return collectionView.c.reusableHeader(atSection: indexPath.section) ?? UICollectionReusableView()
        } else if kind == UICollectionView.elementKindSectionFooter {
            return collectionView.c.reusableFooter(atSection: indexPath.section) ?? UICollectionReusableView()
        }
        return UICollectionReusableView()
    }
}

extension CXYCollectionDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelect?(collectionView, indexPath)
        
        let item = collectionView.c.cellItem(forIndexPath: indexPath)
        item?.closure?(item?.data, indexPath)
    }
}
