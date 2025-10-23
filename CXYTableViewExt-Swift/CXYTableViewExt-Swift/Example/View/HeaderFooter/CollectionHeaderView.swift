//
//  CollectionHeaderView.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    var titleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        backgroundColor = .systemBackground
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .label
    }
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

//
//  CollectionFooterView.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/8.
//

import UIKit

class CollectionFooterView: UICollectionReusableView {
    
    var infoLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubview(infoLabel)
        infoLabel.frame = bounds
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .systemGroupedBackground
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        infoLabel.textColor = .secondaryLabel
        infoLabel.textAlignment = .center
    }
}

extension CollectionFooterView: CXYCollectionHeaderFooterProtocol {
    
    static func sizeForHeaderFooter(data: Any?) -> CGSize {
        return CGSize(width: 0, height: 30)
    }
    
    func configHeaderFooter(data: Any?) {
        if let info = data as? String {
            infoLabel.text = info
        }
    }
}
