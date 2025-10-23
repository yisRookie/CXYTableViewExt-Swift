//
//  BoardModelsViewController.swift
//  CXYTableViewExt-Swift
//
//  Created by ·峰 on 2025/4/21.
//

import UIKit

class BoardModelsViewController: UIViewController {

    lazy var tableview = UITableView(frame:CGRectMake(0, 0, 300, 300), style: .plain)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableview)
        tableview.t.makeConfig { make in
            make.addCellItem(cellClass: LineCell.self)

            make.addCellItem(cellClass: ArrowCell.self,
                             data: SettingModel(title: "BaseTableController",
                                                detail: "基类实现代理")) {
                [weak self] data, indexPath in
                self?.navigationController?.pushViewController(BoardModelsViewController(), animated: true)
            }

            make.addCellItem(cellClass: ArrowCell.self,
                             data: SettingModel(title: "Refresh&LoadMore", detail: "下拉刷新&加载更多")) { [weak self] data, indexPath in
                self?.navigationController?.pushViewController(RefreshController(), animated: true)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
