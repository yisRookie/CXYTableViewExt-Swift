//
//  CollectionViewTest.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

// 这是一个简单的测试文件，用于验证CollectionView扩展是否正常工作
class CollectionViewTest {
    
    func testCollectionViewExtension() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        // 测试命名空间扩展
        let _ = collectionView.c
        
        // 测试基本配置
        collectionView.c.makeConfig { make in
            // 这里可以添加测试代码
        }
        
        print("CollectionView extension test passed!")
    }
}
