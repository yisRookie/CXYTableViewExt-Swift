//  CXYCollectionDataItem.swift
import Foundation

public typealias CXYCollectionItemClosure = (_ data: Any?, _ indexPath: IndexPath) -> Void

public struct CXYCollectionDataItem {
    var itemClass: AnyClass
    var data: Any?
    weak var delegate: AnyObject?
    var closure: CXYCollectionItemClosure?
}

public class CXYCollectionSectionItem {
    public var headerItem: CXYCollectionDataItem?
    public var footerItem: CXYCollectionDataItem?
    public var cellItems = [CXYCollectionDataItem]()
}
