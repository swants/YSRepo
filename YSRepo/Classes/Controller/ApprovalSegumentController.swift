//
//  ApprovalSegumentController.swift
//  hybridDemo
//
//  Created by Swants on 2018/6/29.
//  Copyright © 2018年 ctsi. All rights reserved.
//

import UIKit
import MMBase


class ApprovalSegumentController: BaseViewController,SegumentViewProtocol {
    private var segument = SegumentView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 50), titles: ["我的待办","我的已办"])
    private let contentView = UIView(frame: CGRect(x: 0, y:50, width: kScreenW, height:kScreenH - HEIGHT_NAVIGATION_BAR - HEIGHT_STATUS_BAR - 50))
    
    
    private let GTasksVC =  ApprovalTasksController(approvalTaskState: .GTasks)
    private let TaskFinishVC = ApprovalTasksController(approvalTaskState: .Finish)
    private var selectController :UIViewController? = nil
    
  
    
    func changeIndexAction(index: NSInteger) {
        var toVC: UIViewController? = nil
        
        if index == 0 {
            toVC = GTasksVC
        }else if index == 1{
            toVC = TaskFinishVC
        }
        if toVC == selectController{
            return
        }
        self.transition(from: selectController!, to: toVC!, duration: 0, options:.allowUserInteraction , animations: nil) { (success) in
            if success{
                self.selectController = toVC
            }
        }
        
    }
    
    @objc
    func injected() {
        print("I've been injected: \(self)")
   
        FileUtil.componentSaveFile(componentDirectoryPath: FileUtil.getDocumentsDirectory(), directoryName: "app2", fileName: "33", fileData: "11".data(using:.utf8)!)
//        FileUtil.componentGetFile(componentDirectoryPath: FileUtil.getDocumentsDirectory(), directoryName: "app", fileName: "22")
        FileUtil.componentRemoveFiles(componentDirectoryPath: FileUtil.getDocumentsDirectory(), directoryName: "app2")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.baseSetNavLeftButtonIsBack()
        title = "审批管理"
        view.addSubview(segument)
        segument.delegte = self
        
        self.addChildViewController(GTasksVC)
        self.addChildViewController(TaskFinishVC)
        
        view.addSubview(contentView)
        
        contentView.addSubview(GTasksVC.view)
        selectController = GTasksVC
    }
    
}
