//  CXYCollectionItemProtocol.swift
import Foundation
import UIKit

public protocol CXYCollectionItemProtocol: AnyObject {
    
    static func sizeForItem(data: Any?) -> CGSize
    
    func configItem(data: Any?)
    func configItem(data: Any?, indexPath: IndexPath, delegate: AnyObject?)
}

extension CXYCollectionItemProtocol {
    
    static func sizeForItem(data: Any?) -> CGSize { 
        return CGSize(width: 50, height: 50) 
    }
    
    func configItem(data: Any?) {}
    func configItem(data: Any?, indexPath: IndexPath, delegate: AnyObject?) {}
}

// MARK: - Header/Footer Protocol
public protocol CXYCollectionHeaderFooterProtocol: AnyObject {
    
    static func sizeForHeaderFooter(data: Any?) -> CGSize
    
    func configHeaderFooter(data: Any?)
    func configHeaderFooter(data: Any?, indexPath: IndexPath, delegate: AnyObject?)
}

extension CXYCollectionHeaderFooterProtocol {
    
    static func sizeForHeaderFooter(data: Any?) -> CGSize { 
        return CGSize(width: 0, height: 0) 
    }
    
    func configHeaderFooter(data: Any?) {}
    func configHeaderFooter(data: Any?, indexPath: IndexPath, delegate: AnyObject?) {}
}
