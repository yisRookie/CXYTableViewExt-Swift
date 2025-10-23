//
//  CollectionViewController.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

class CollectionViewController: UIViewController {
        
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize;
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRectMake(0, 100, self.view.frame.size.width, 100), collectionViewLayout: self.layout)
        collectionView.backgroundColor = .systemGray
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CollectionView Example"
        setupCollectionView()
        configCollectionView()
    }
    
    private func setupCollectionView() {
        self.view.addSubview(collectionView)
    }
    
    func configCollectionView() {
        
        // 创建示例数据
        let imageModels = [
            CollectionImageModel(title: "Heart", imageName: "heart.fill", color: .systemRed),
            CollectionImageModel(title: "Star",  imageName: "star.fill", color: .systemYellow),
            CollectionImageModel(title: "Moon",  imageName: "moon.fill", color: .systemBlue),
            CollectionImageModel(title: "Sun",   imageName: "sun.max.fill", color: .systemOrange),
            CollectionImageModel(title: "Cloud", imageName: "cloud.fill", color: .systemGray),
            CollectionImageModel(title: "Leaf",  imageName: "leaf.fill", color: .systemGreen),
            CollectionImageModel(title: "Flame", imageName: "flame.fill", color: .systemRed),
            CollectionImageModel(title: "Snow",  imageName: "snow", color: .systemBlue),
            CollectionImageModel(title: "Drop",  imageName: "drop.fill", color: .systemBlue),
            CollectionImageModel(title: "Sparkles", imageName: "sparkles", color: .systemPurple),
            CollectionImageModel(title: "Camera", imageName: "camera.fill", color: .systemGray),
            CollectionImageModel(title: "Music", imageName: "music.note", color: .systemPink)
            
        ]
        
        self.collectionView.c.makeConfig { make in
            // 添加多个Cell
            make.addCellItems(cellClass: CollectionImageCell.self, dataList: imageModels)
        }
        
        self.collectionView.c.addCellItem(cellClass: CollectionImageCell.self, data: CollectionImageModel(title: "Music2", imageName: "music.note", color: .systemPink))
        
        self.collectionView.c.addCellItem(cellClass: CollectionImageCell.self, data:  CollectionImageModel(title: "Musicss3", imageName: "music.note", color: .systemPink)) { data, indexPath in
         print("-------------")
         print("indexPath(\(indexPath)), data = \(String(describing: data))")
        }
        
        // 处理CollectionView的点击事件
        self.collectionView.c.didSelectItem { collectionView, indexPath in
            collectionView.deselectItem(at: indexPath, animated: true)
            
            // 获取点击的数据
            let data = collectionView.c.cellItemData(forIndexPath: indexPath)
            print("did select indexPath(\(indexPath)), data = \(String(describing: data))")
        }
    }
}
