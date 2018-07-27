//
//  ApprovalListController.swift
//  hybridDemo
//
//  Created by Swants on 2018/7/2.
//  Copyright © 2018年 ctsi. All rights reserved.
//

import UIKit
import MMBase
import SnapKit

enum ApprovalTaskState {
    case GTasks
    case Finish
}

class ApprovalTasksController: BaseViewController,UITableViewDataSource, UITableViewDelegate {
    public var taskState: ApprovalTaskState
    private var cellIdentifier: String
    
    private lazy var _tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: view.height - 50 - MTSStatusBarH - HEIGHT_NAVIGATION_BAR))
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ApprovalGTasksCell.classForCoder(), forCellReuseIdentifier: "ApprovalGTasksCell")
        tableView.register(ApprovalTaskFinishCell.classForCoder(), forCellReuseIdentifier: "ApprovalTaskFinishCell")

        return tableView
    }()
    
    
     init(approvalTaskState:ApprovalTaskState) {
        taskState = approvalTaskState
        cellIdentifier = (taskState == .GTasks) ? "ApprovalGTasksCell" : "ApprovalTaskFinishCell"
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
      self.init(approvalTaskState: .GTasks)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(_tableView)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc: ApprovalDetialController = ApprovalDetialController(approvalTaskState: taskState)
        vc.approvalId = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
