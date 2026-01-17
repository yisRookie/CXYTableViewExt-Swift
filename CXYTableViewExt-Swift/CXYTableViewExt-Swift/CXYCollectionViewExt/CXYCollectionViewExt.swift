//  CXYCollectionViewExt.swift
import Foundation
import UIKit

extension UICollectionView: CXYTableNamespaceWrappable { }

extension CXYTableNamespaceWrapper where T: UICollectionView {
    
    public func configDataSource(_ dataSource: CXYCollectionDataSource) {
        table.defaultDataSource = dataSource
        table.dataSource = dataSource
        table.delegate = dataSource
    }
    
    public func makeConfig(_ closure: @escaping (_ make: Self) -> Void) {
        removeItems()
        closure(table.c)
        table.reloadData()
    }
    
    public func useDefaultDataSource() {
        configDataSource(CXYCollectionDataSource())
    }
}

extension CXYTableNamespaceWrapper where T: UICollectionView {
    
    func register(itemClasses clss: Array<AnyClass>) {
        for cls in clss {
            self.register(itemClass: cls)
        }
    }
    
    func register(itemClass cls: AnyClass) {
        let name = String(describing: cls)
        // Prefer nibs from the class's bundle; fall back to main bundle
        let classBundle = Bundle(for: cls)
        let mainNibPath = Bundle.main.path(forResource: name, ofType: "nib")
        let classNibPath = classBundle.path(forResource: name, ofType: "nib")
        let nibBundle: Bundle? = (mainNibPath != nil) ? Bundle.main : ((classNibPath != nil) ? classBundle : nil)

        if cls is UICollectionViewCell.Type {
            if let bundle = nibBundle {
                table.register(UINib(nibName: name, bundle: bundle), forCellWithReuseIdentifier: name)
            } else {
                table.register(cls, forCellWithReuseIdentifier: name)
            }
            
        } else if cls is UICollectionReusableView.Type {
            if let bundle = nibBundle {
                table.register(UINib(nibName: name, bundle: bundle), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: name)
                table.register(UINib(nibName: name, bundle: bundle), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: name)
            } else {
                table.register(cls, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: name)
                table.register(cls, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: name)
            }
        } else {
            fatalError("\(name) is an illegal class!")
        }
    }
}

/**
 *  添加item
 */
public extension CXYTableNamespaceWrapper where T: UICollectionView {
   
    func addHeaderItem(headerClass cls: AnyClass, data: Any?, delegate: AnyObject? = nil) {
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()

        let headerItem = CXYCollectionDataItem(itemClass: cls, data: data, delegate: delegate)
     
        if let sec = table.m.sections.last, isEmpty(sectionItem: sec) {
            sec.headerItem = headerItem
        } else {
            let sectionItem = CXYCollectionSectionItem()
            sectionItem.headerItem = headerItem
            table.m.sections.append(sectionItem)
        }
    }

    func addCellItem(cellClass cls: AnyClass, data: Any? = nil) {
        addCellItem(cellClass: cls, data: data, delegate: nil, closure: nil)
    }
    
    func addCellItem(cellClass cls: AnyClass, delegate: AnyObject?) {
        addCellItem(cellClass: cls, data: nil, delegate: delegate, closure: nil)
    }
    
    func addCellItem(cellClass cls: AnyClass, closure: CXYCollectionItemClosure?) {
        addCellItem(cellClass: cls, data: nil, delegate: nil, closure: closure)
    }
    
    func addCellItem(cellClass cls: AnyClass, data: Any?, closure: CXYCollectionItemClosure?) {
        addCellItem(cellClass: cls, data: data, delegate: nil, closure: closure)
    }
    
    func addCellItem(cellClass cls: AnyClass, data: Any?, delegate: AnyObject?, closure: CXYCollectionItemClosure? = nil) {
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()
        
        if let sec = table.m.sections.last {
            if let _ = sec.footerItem {
                table.m.sections.append(CXYCollectionSectionItem())
            }
        } else {
            table.m.sections.append(CXYCollectionSectionItem())
        }
        
        let sectionItem = table.m.sections.last;
        
        let cellItem = CXYCollectionDataItem(itemClass: cls, data: data, delegate: delegate, closure: closure)
        sectionItem?.cellItems.append(cellItem)
    }
    
    func addCellItems(cellClass cls: AnyClass, dataList: Array<Any?>, delegate: AnyObject? = nil) {
        if dataList.isEmpty {
            return
        }
        
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()
        
        let items = dataList.map {
            CXYCollectionDataItem(itemClass: cls, data: $0, delegate: delegate)
        }
        
        if let sec = table.m.sections.last {
            if let _ = sec.footerItem {
                table.m.sections.append(CXYCollectionSectionItem())
            }
        } else {
            table.m.sections.append(CXYCollectionSectionItem())
        }
        
        let sectionItem = table.m.sections.last;
        sectionItem?.cellItems += items
    }
    

    func addFooterItem(footerClass cls: AnyClass, data: Any?, delegate: AnyObject? = nil) {
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()

        let footerItem = CXYCollectionDataItem(itemClass: cls, data: data, delegate: delegate)
        if let _ = table.m.sections.last?.footerItem {
            let sectionItem = CXYCollectionSectionItem()
            table.m.sections.append(sectionItem)
            sectionItem.footerItem = footerItem
        } else {
            table.m.sections.last?.footerItem = footerItem
        }
    }
    
    func didSelectItem(didSelect: @escaping DidSelectCollectionHandler) {
        table.defaultDataSource?.didSelect = didSelect
    }
}

/**
 *  插入item
 */
public extension CXYTableNamespaceWrapper where T: UICollectionView {
    func insertHeaderItem(headerClass cls: AnyClass, data: Any?, section: Int) {
        insertHeaderItem(headerClass: cls, data: data, delegate: nil, section: section)
    }
    
    func insertHeaderItem(headerClass cls: AnyClass, data: Any?, delegate: AnyObject?, section: Int) {
        guard table.m.sections.count >= section else {
            assertionFailure("section(\(section) is out of range")
            return
        }
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()
        
        let headerItem = CXYCollectionDataItem(itemClass: cls, data: data, delegate: delegate)

        if let sec = sectionItem(section: section), sec.headerItem==nil {
            sec.headerItem = headerItem
        } else {
            let sectionItem = CXYCollectionSectionItem()
            sectionItem.headerItem = headerItem
            table.m.sections.insert(sectionItem, at: section)
        }
    }
    
    func insertCellItem(cellClass cls: AnyClass, data: Any?, indexPath: IndexPath) {
        insertCellItem(cellClass: cls, data: data, delegate: nil, indexPath: indexPath)
    }
    
    func insertCellItem(cellClass cls: AnyClass, data: Any?, delegate: AnyObject?, indexPath: IndexPath) {
        insertCellItems(cellClass: cls, dataList: [data], delegate: delegate, indexPath: indexPath)
    }
    
    func insertCellItems(cellClass cls: AnyClass, dataList: Array<Any?>, indexPath: IndexPath) {
        insertCellItems(cellClass: cls, dataList:dataList, delegate: nil, indexPath: indexPath)
    }
    
    func insertCellItems(cellClass cls: AnyClass, dataList: Array<Any?>, delegate: AnyObject?, indexPath: IndexPath) {
        
        guard table.m.sections.count >= indexPath.section else {
            assertionFailure("section(\(indexPath.section)) is out of range")
            return
        }
        
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()
        
        let items = dataList.map {
            CXYCollectionDataItem(itemClass: cls, data: $0, delegate: delegate)
        }
        
        let sectionItem = sectionItem(section: indexPath.section)
        if let sec = sectionItem {
            guard sec.cellItems.count >= indexPath.row else {
                assertionFailure("row(\(indexPath.row)) is out of range")
                return
            }
            sec.cellItems.insert(contentsOf: items, at: indexPath.row)
        } else if table.m.sections.count >= indexPath.section {
            let sectionItem = CXYCollectionSectionItem()
            sectionItem.cellItems = items
            table.m.sections.insert(sectionItem, at: indexPath.section)
        }
    }
    
    func insertFooterItem(footerClass cls: AnyClass, data: Any?, section: Int) {
        insertFooterItem(footerClass: cls, data: data, delegate: nil, section: section)
    }
     
    func insertFooterItem(footerClass cls: AnyClass, data: Any?, delegate: AnyObject?, section: Int) {
       
        guard table.m.sections.count >= section else {
            assertionFailure("section(\(section)) is out of range")
            return
        }
        
        registerIfNeed(itemClass: cls)
        useDefaultDataSourceIfNeed()

        let footerItem = CXYCollectionDataItem(itemClass: cls, data: data, delegate: delegate)
        
        if let sec = sectionItem(section: section), sec.footerItem==nil {
            sec.footerItem = footerItem
        } else if table.m.sections.count >= section {
            let sectionItem = CXYCollectionSectionItem()
            sectionItem.footerItem = footerItem
            table.m.sections.insert(sectionItem, at: section)
        }
    }
}

/**
 *  删除item
 */
public extension CXYTableNamespaceWrapper where T: UICollectionView {
    
    func removeItems() {
        table.m.sections.removeAll()
    }
    
    func removeSectionItem(section: Int) {
        table.m.sections.remove(at: section)
    }
    
    func removeHeaderItem(section: Int) {
        let sectionItem = table.c.sectionItem(section: section)
        sectionItem?.headerItem = nil
    }
    
    func removeCellItem(indexPath: IndexPath) {
        let sectionItem = table.c.sectionItem(section: indexPath.section)
        sectionItem?.cellItems.remove(at: indexPath.row)
    }
    
    func removeFooterItem(section: Int) {
        let sectionItem = table.c.sectionItem(section: section)
        sectionItem?.footerItem = nil
    }
}

/**
 *  判空
 */
public extension CXYTableNamespaceWrapper where T: UICollectionView {
    var isEmpty: Bool {
        let items = sectionItems()
        if items.isEmpty {
            return true
        }
        
        for item in items {
            if !isEmpty(sectionItem: item) {
                return false
            }
        }
        return true
    }
    
    func isEmpty(sectionItem: CXYCollectionSectionItem) -> Bool {
        if let _ = sectionItem.headerItem {
            return false
        }
        if let _ = sectionItem.footerItem {
            return false
        }
        if !sectionItem.cellItems.isEmpty {
            return false
        }
        return true
    }
        
    func isEmptyCellItem(forSectionItem sectionItem: CXYCollectionSectionItem) -> Bool {
        return sectionItem.cellItems.isEmpty
    }
}

/**
 *  获取item
 */
public extension CXYTableNamespaceWrapper where T: UICollectionView {
    
    func sectionItems() -> Array<CXYCollectionSectionItem> {
        return table.m.sections
    }
    
    func sectionItem(section: Int) -> CXYCollectionSectionItem? {
        if 0 <= section && section < table.m.sections.count {
            return table.m.sections[section]
        }
        return nil
    }
    
    func headerItemData(section: Int) -> Any? {
        return sectionItem(section: section)?.headerItem?.data
    }
    
    func headerItemDelegate(section: Int) -> AnyObject? {
        return sectionItem(section: section)?.headerItem?.delegate
    }
    
    func headerItemClass(section: Int) -> AnyClass? {
        return sectionItem(section: section)?.headerItem?.itemClass
    }
    
    func footerItemData(section: Int) -> Any? {
        return sectionItem(section: section)?.footerItem?.data
    }
    
    func footerItemDelegate(section: Int) -> AnyObject? {
        return sectionItem(section: section)?.footerItem?.delegate
    }
    
    func footerItemClass(section: Int) -> AnyClass? {
        return sectionItem(section: section)?.footerItem?.itemClass
    }
    
    func cellItems(section: Int) -> Array<CXYCollectionDataItem>? {
        return sectionItem(section: section)?.cellItems
    }
    
    func cellItem(forIndexPath indexPath: IndexPath) -> CXYCollectionDataItem? {
        guard let cellItems = cellItems(section: indexPath.section) else {
            return nil
        }
        if 0 <= indexPath.row && indexPath.row < cellItems.count {
            return cellItems[indexPath.row]
        }
        return nil
    }
    
    func cellItemData(forIndexPath indexPath: IndexPath) -> Any? {
        return cellItem(forIndexPath:indexPath)?.data
    }
    
    func cellItemDelegate(forIndexPath indexPath: IndexPath) -> AnyObject? {
        return cellItem(forIndexPath:indexPath)?.delegate
    }
    
    func cellItemClass(forIndexPath indexPath: IndexPath) -> AnyClass? {
        return cellItem(forIndexPath:indexPath)?.itemClass
    }
    
    func headerItemDataList() -> Array<Any?> {
        var list = [Any?]()
        table.m.sections.forEach { item in
            if let headerItem = item.headerItem {
                list.append(headerItem.data)
            }
        }
        return list
    }
    
    func footerItemDataList() -> Array<Any?> {
        var list = [Any?]()
        table.m.sections.forEach { item in
            if let footerItem = item.footerItem {
                list.append(footerItem.data)
            }
        }
        return list
    }
    
    func cellItemDataList(section: Int) -> Array<Any?> {
        var list = [Any?]()
        cellItems(section: section)?.forEach { item in
            list.append(item.data)
        }
        return list
    }
}

/**
 *  获取item数量
 */
public extension CXYTableNamespaceWrapper where T: UICollectionView {
    func numberOfSections() -> Int {
        return max(1, table.m.sections.count)
    }
    
    func numberOfCellItems(atSection section: Int) -> Int {
        if section > table.m.sections.count || 0 > section || table.m.sections.isEmpty {
            return 0
        }
        return table.m.sections[section].cellItems.count
    }
}

/**
 *  获取item尺寸
 */
public extension CXYTableNamespaceWrapper where T: UICollectionView {
        
    func sizeForHeader(atSection section: Int) -> CGSize {
        guard let headerItem = sectionItem(section: section)?.headerItem,
              let cls = headerItem.itemClass as? CXYCollectionHeaderFooterProtocol.Type else {
            return .zero
        }
        return cls.sizeForHeaderFooter(data: headerItem.data)
    }
    
    func sizeForFooter(atSection section: Int) -> CGSize {
        guard let footerItem = sectionItem(section: section)?.footerItem,
              let cls = footerItem.itemClass as? CXYCollectionHeaderFooterProtocol.Type else {
            return .zero
        }
        return cls.sizeForHeaderFooter(data: footerItem.data)
    }
}

/**
 *  获取重用item
 */
public extension CXYTableNamespaceWrapper where T: UICollectionView {
    func reusableCell(atIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellItem = cellItem(forIndexPath: indexPath) else {
            assertionFailure("cellItem is nil at indexPath: \(indexPath)")
            return UICollectionViewCell()
        }
        let itemClass: AnyClass = cellItem.itemClass
        // Ensure class is registered before dequeuing
        registerIfNeed(itemClass: itemClass)
        let cell = table.dequeueReusableCell(withReuseIdentifier: String(describing: itemClass), for: indexPath)
        if let c = cell as? CXYCollectionItemProtocol {
            c.configItem(data: cellItem.data)
            c.configItem(data: cellItem.data, indexPath: indexPath, delegate: cellItem.delegate)
        }
        return cell
    }
    
    func reusableHeader(atSection section: Int) -> UICollectionReusableView? {
        let headerItem = sectionItem(section: section)?.headerItem
        let cls: AnyClass? = headerItem?.itemClass
        guard let itemClass = cls else {
            return dequeueEmptySupplementary(kind: UICollectionView.elementKindSectionHeader, section: section)
        }
        // Ensure registration
        registerIfNeed(itemClass: itemClass)
        let header = table.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: itemClass), for: IndexPath(item: 0, section: section))
        if let h = header as? CXYCollectionHeaderFooterProtocol {
            h.configHeaderFooter(data: headerItem?.data)
            h.configHeaderFooter(data: headerItem?.data, indexPath: IndexPath(item: 0, section: section), delegate: headerItem?.delegate)
        }
        return header
    }
    
    func reusableFooter(atSection section: Int) -> UICollectionReusableView? {
        let footerItem = sectionItem(section: section)?.footerItem
        let cls: AnyClass? = footerItem?.itemClass
        guard let itemClass = cls else {
            return dequeueEmptySupplementary(kind: UICollectionView.elementKindSectionFooter, section: section)
        }
        // Ensure registration
        registerIfNeed(itemClass: itemClass)
        let footer = table.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: itemClass), for: IndexPath(item: 0, section: section))
        if let f = footer as? CXYCollectionHeaderFooterProtocol {
            f.configHeaderFooter(data: footerItem?.data)
            f.configHeaderFooter(data: footerItem?.data, indexPath: IndexPath(item: 0, section: section), delegate: footerItem?.delegate)
        }
        return footer
    }
}

public extension CXYTableNamespaceWrapper where T: UICollectionView  {
    var vc: UIViewController? {
        var parentResponder: UIResponder? = self.table
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

/**
 *  注册&代理，设置
 */
private extension CXYTableNamespaceWrapper where T: UICollectionView  {
    func registerIfNeed(itemClass cls: AnyClass) {
        let name = String(describing: cls)
        guard let _ = table.registeredClasses[name] else {
            register(itemClass: cls)
            table.registeredClasses[name] = cls
            return
        }
    }

    func useDefaultDataSourceIfNeed() {
        if table.delegate==nil && table.dataSource==nil {
            useDefaultDataSource()
        }
    }
    
    func dequeueEmptySupplementary(kind: String, section: Int) -> UICollectionReusableView? {
        let identifier = "CXYEmptySupplementaryView"
        if table.registeredClasses[identifier] == nil {
            table.register(UICollectionReusableView.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
            table.registeredClasses[identifier] = UICollectionReusableView.self
        }
        return table.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: IndexPath(item: 0, section: section))
    }
}

/**
 *  中转sections，避免数组添加元素频繁调用关联对象set方法
 */
private class CollectionMiddle {
    var sections = [CXYCollectionSectionItem]()
}

/**
 * 添加的关联属性
 */
private extension UICollectionView {
    private struct AssociatedKeys {
        static var kRegisteredClassesKey: UInt8 = 0
        static var kSectionsKey: UInt8 = 0
        static var kDataSourceKey: UInt8 = 0
        static var kMiddleKey: UInt8 = 0
    }
    
    var registeredClasses: Dictionary<String, AnyClass> {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.kRegisteredClassesKey) as? Dictionary<String, AnyClass> else {
                let defaultVaule: [String:AnyClass] = [:]
                self.registeredClasses = defaultVaule
                return defaultVaule
            }
            return value
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kRegisteredClassesKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var m: CollectionMiddle {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.kMiddleKey) as? CollectionMiddle else {
                let defaultVaule = CollectionMiddle()
                objc_setAssociatedObject(self, &AssociatedKeys.kMiddleKey, defaultVaule, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return defaultVaule
            }
            return value
        }
    }
    
    var defaultDataSource : CXYCollectionDataSource? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.kDataSourceKey) as? CXYCollectionDataSource
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kDataSourceKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
