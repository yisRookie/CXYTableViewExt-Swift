//  CXYCollectionItemProtocol.swift
import Foundation
import UIKit

public protocol CXYCollectionItemProtocol: AnyObject {
        
    func configItem(data: Any?)

}

extension CXYCollectionItemProtocol {
    
    func configItem(data: Any?, indexPath: IndexPath, delegate: AnyObject?) {}
}

// MARK: - Header/Footer Protocol
public protocol CXYCollectionHeaderFooterProtocol: AnyObject {
        
    func configHeaderFooter(data: Any?)

}

extension CXYCollectionHeaderFooterProtocol {
    
    static func sizeForHeaderFooter(data: Any?) -> CGSize { 
        return CGSize(width: 0, height: 0) 
    }
    
    func configHeaderFooter(data: Any?) {}
    func configHeaderFooter(data: Any?, indexPath: IndexPath, delegate: AnyObject?) {}
}
