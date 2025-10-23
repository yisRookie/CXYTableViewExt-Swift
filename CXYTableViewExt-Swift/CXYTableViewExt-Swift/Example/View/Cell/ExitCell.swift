//
//  ExitCell.swift
//  CXYTableViewExt-Swift
//
//  Created by cxy on 2022/8/9.
//

import UIKit
import SnapKit

class ExitCell: UITableViewCell {

    var title: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.numberOfLines = 0
        title.textColor = .systemRed
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.title)
        title.snp.makeConstraints { make in
            make.edges.equalToSuperview()
//            make.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ExitCell: CXYTableItemProtocol {
    static func heightForItem(data: Any?) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func configItem(data: Any?) {
        if let t = data as? String {
            self.title.text = t
        }
    }
}
