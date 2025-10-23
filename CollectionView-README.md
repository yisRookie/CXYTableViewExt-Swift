# CXYTableViewExt-Swift - CollectionView Support

## CollectionView 扩展使用指南

基于现有的 CXYTableViewExt-Swift 框架，我们新增了对 UICollectionView 的支持，提供了与 TableView 相同的简洁配置方式。

## 核心特性

- ✅ 无需手动注册 Cell
- ✅ 链式API调用
- ✅ 支持 Header/Footer
- ✅ 自动数据源管理
- ✅ 类型安全的配置
- ✅ 支持闭包回调

## 使用方法

### 1. 自定义 Cell 并实现协议

```swift
class CollectionImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
}

extension CollectionImageCell: CXYCollectionItemProtocol {
    
    static func sizeForItem(data: Any?) -> CGSize {
        return CGSize(width: 120, height: 150)
    }
    
    func configItem(data: Any?) {
        if let model = data as? CollectionImageModel {
            titleLabel.text = model.title
            imageView.image = UIImage(systemName: model.imageName)
            imageView.tintColor = model.color
        }
    }
}
```

### 2. 配置 CollectionView

```swift
func configCollectionView() {
    let imageModels = [
        CollectionImageModel(title: "Heart", imageName: "heart.fill", color: .systemRed),
        CollectionImageModel(title: "Star", imageName: "star.fill", color: .systemYellow),
        // ... 更多数据
    ]
    
    self.collectionView.c.makeConfig { make in
        
        // 添加多个Cell
        make.addCellItems(cellClass: CollectionImageCell.self, dataList: imageModels) { data, indexPath in
            if let model = data as? CollectionImageModel {
                print("Selected item: \(model.title)")
            }
        }
    }
    
    // 处理点击事件
    self.collectionView.c.didSelectItem { collectionView, indexPath in
        collectionView.deselectItem(at: indexPath, animated: true)
        let data = collectionView.c.cellItemData(forIndexPath: indexPath)
        print("Selected data: \(String(describing: data))")
    }
}
```

### 3. 支持 Header/Footer

```swift
// Header 实现
class CollectionHeaderView: UICollectionReusableView {
    @IBOutlet weak var titleLabel: UILabel!
}

extension CollectionHeaderView: CXYCollectionHeaderFooterProtocol {
    
    static func sizeForHeaderFooter(data: Any?) -> CGSize {
        return CGSize(width: 0, height: 40)
    }
    
    func configHeaderFooter(data: Any?) {
        if let title = data as? String {
            titleLabel.text = title
        }
    }
}

// 使用 Header/Footer
self.collectionView.c.makeConfig { make in
    
    // 添加 Header
    make.addHeaderItem(headerClass: CollectionHeaderView.self, data: "Section Title")
    
    // 添加 Cells
    make.addCellItems(cellClass: CollectionImageCell.self, dataList: models)
    
    // 添加 Footer
    make.addFooterItem(footerClass: CollectionFooterView.self, data: "Section Footer")
}
```

## API 对比

| 功能 | TableView | CollectionView |
|------|-----------|----------------|
| 命名空间 | `.t` | `.c` |
| 协议 | `CXYTableItemProtocol` | `CXYCollectionItemProtocol` |
| 数据项 | `CXYTableDataItem` | `CXYCollectionDataItem` |
| 分组项 | `CXYTableSectionItem` | `CXYCollectionSectionItem` |
| 数据源 | `CXYTableDataSource` | `CXYCollectionDataSource` |
| 尺寸方法 | `heightForItem` | `sizeForItem` |

## 主要 API

### 添加 Cell
```swift
// 单个Cell
make.addCellItem(cellClass: MyCell.self, data: model)

// 多个Cell
make.addCellItems(cellClass: MyCell.self, dataList: models)

// 带回调的Cell
make.addCellItem(cellClass: MyCell.self, data: model) { data, indexPath in
    // 处理点击事件
}
```

### 添加 Header/Footer
```swift
make.addHeaderItem(headerClass: MyHeader.self, data: "Title")
make.addFooterItem(footerClass: MyFooter.self, data: "Footer")
```

### 获取数据
```swift
let data = collectionView.c.cellItemData(forIndexPath: indexPath)
let cellItem = collectionView.c.cellItem(forIndexPath: indexPath)
```

## 注意事项

1. **命名空间**: CollectionView 使用 `.c` 命名空间，TableView 使用 `.t`
2. **尺寸设置**: CollectionView 使用 `sizeForItem` 返回 `CGSize`，TableView 使用 `heightForItem` 返回 `CGFloat`
3. **Header/Footer**: CollectionView 的 Header/Footer 需要实现 `CXYCollectionHeaderFooterProtocol` 协议
4. **自动注册**: 框架会自动注册 Cell 和 Header/Footer，无需手动注册

## 示例项目

查看 `Example` 文件夹中的示例：
- `CollectionViewController.swift` - 基础 CollectionView 使用
- `CollectionWithHeaderFooterController.swift` - 带 Header/Footer 的 CollectionView
- `CollectionImageCell.swift` - 自定义 Cell 实现
- `CollectionHeaderView.swift` - Header/Footer 实现
