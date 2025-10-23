//
//  CollectionImageCell.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

class CollectionImageCell: UICollectionViewCell {
    
    var imageView =  UIImageView()
    var titleLabel = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView.backgroundColor = UIColor.white
        self.titleLabel.backgroundColor = UIColor.yellow
        
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.titleLabel)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        backgroundColor = .red
        
        self.imageView.snp.makeConstraints { make in
            make.left.top.equalTo(10)
            make.height.width.equalTo(50)
            make.bottom.equalTo(-10);
        }
        
        self.titleLabel.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(10)
            make.top.equalTo(imageView)
            make.right.equalTo(-10);
            make.bottom.equalTo(-10)
        }
    }
}

extension CollectionImageCell: CXYCollectionItemProtocol {
    
//    static func sizeForItem(data: Any?) -> CGSize {
//        return CGSize(width: 120, height: 150)
//    }
    
    func configItem(data: Any?) {
        if let model = data as? CollectionImageModel {
            titleLabel.text = model.title
            imageView.image = UIImage(systemName: model.imageName)
            imageView.tintColor = model.color
        }
    }
}

// MARK: - Data Model
struct CollectionImageModel {
    let title: String
    let imageName: String
    let color: UIColor
}
