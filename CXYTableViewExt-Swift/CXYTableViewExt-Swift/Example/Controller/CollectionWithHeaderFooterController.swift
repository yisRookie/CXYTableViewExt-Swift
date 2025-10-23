//
//  CollectionWithHeaderFooterController.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

class CollectionWithHeaderFooterController: UIViewController {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CollectionView with Header/Footer"
        setupCollectionView()
        configCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .systemGroupedBackground
        self.view.addSubview(collectionView)
    }
    
    func configCollectionView() {
        
        // 第一组数据
        let firstGroupModels = [
            CollectionImageModel(title: "Heart", imageName: "heart.fill", color: .systemRed),
            CollectionImageModel(title: "Star", imageName: "star.fill", color: .systemYellow),
            CollectionImageModel(title: "Moon", imageName: "moon.fill", color: .systemBlue)
        ]
        
        // 第二组数据
        let secondGroupModels = [
            CollectionImageModel(title: "Sun", imageName: "sun.max.fill", color: .systemOrange),
            CollectionImageModel(title: "Cloud", imageName: "cloud.fill", color: .systemGray),
            CollectionImageModel(title: "Leaf", imageName: "leaf.fill", color: .systemGreen)
        ]
        
        self.collectionView.c.makeConfig { make in
            
            // 第一组
            make.addHeaderItem(headerClass: CollectionHeaderView.self, data: "Nature Icons")
            make.addCellItems(cellClass: CollectionImageCell.self, dataList: firstGroupModels)
            make.addFooterItem(footerClass: CollectionFooterView.self, data: "First group with 3 items")
            
            // 第二组
            make.addHeaderItem(headerClass: CollectionHeaderView.self, data: "Weather Icons")
            make.addCellItems(cellClass: CollectionImageCell.self, dataList: secondGroupModels)
            make.addFooterItem(footerClass: CollectionFooterView.self, data: "Second group with 3 items")
        }
        
        // 处理CollectionView的点击事件
        self.collectionView.c.didSelectItem { collectionView, indexPath in
            collectionView.deselectItem(at: indexPath, animated: true)
            
            let data = collectionView.c.cellItemData(forIndexPath: indexPath)
            print("did select indexPath(\(indexPath)), data = \(String(describing: data))")
        }
    }
}
