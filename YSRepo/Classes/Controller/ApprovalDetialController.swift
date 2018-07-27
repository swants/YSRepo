//
//  ApprovalDetialController.swift
//  hybridDemo
//
//  Created by Swants on 2018/7/3.
//  Copyright © 2018年 ctsi. All rights reserved.
//

import UIKit
import MMBase
import WebKit
import SnapKit



class ApprovalDetialController: BaseViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    public var approvalState :ApprovalTaskState
    public var approvalId: NSInteger = 0
    
    private lazy var webView: WKWebView = {
        let config :WKWebViewConfiguration = WKWebViewConfiguration()
        config.userContentController.add(self, name: "appFunc")
        let  preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = true
        config.preferences = preferences
        
        let webView = WKWebView(frame: view.bounds,configuration:config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        return webView
    }()
    
    lazy private var progressView: UIProgressView = {
        let progressView = UIProgressView.init(frame: CGRect(x: CGFloat(0), y: CGFloat(1), width: UIScreen.main.bounds.width, height: 2))
        progressView.tintColor = #colorLiteral(red: 0.09520434947, green: 0.436741737, blue: 0.8748380829, alpha: 0.7524757923)     // 进度条颜色
        progressView.trackTintColor = UIColor.white // 进度条背景色
        return progressView
    }()
    
    private lazy var footerView: UIView = {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: 50))
        footerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        footerView.addSingleBorder(direct: .top, color: UIColor.colorFromHex(0xCACACA), width: 0.5)
    
        footerView.addSubview(refuseBtn)
        refuseBtn.snp.makeConstraints({ (maker) in
            maker.left.top.bottom.equalToSuperview()
            maker.width.equalTo(kScreenW*0.5)
        })
        
        footerView.addSubview(agreeBtn)
        agreeBtn.snp.makeConstraints({ (maker) in
            maker.right.top.bottom.equalToSuperview()
            maker.width.equalTo(kScreenW*0.5)
        })
        return footerView
    }()
    
    private lazy var refuseBtn: UIButton = {
        let refuseBtn = UIButton()
        refuseBtn.backgroundColor = UIColor.colorFromHex(0xE4E4E4)
        refuseBtn.setTitle("退回", for: .normal)
        refuseBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        refuseBtn .setTitleColor(UIColor.colorFromHex(0x333333), for: .normal)
        refuseBtn.addTarget(self, action: #selector(refuseApprovalApply), for: .touchUpInside)
        return refuseBtn
    }()
    
    private lazy var agreeBtn: UIButton = {
        let agreeBtn = UIButton()
        agreeBtn.backgroundColor = UIColor.colorFromHex(0xE4E4E4)
        agreeBtn.setTitle("同意", for: .normal)
        agreeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        agreeBtn.setTitleColor(UIColor.colorFromHex(0x333333), for: .normal)
        agreeBtn.addSingleBorder(direct:.left, color: UIColor.colorFromHex(0xCACACA), width: 0.5)
        agreeBtn.addTarget(self, action: #selector(agreeApprovalApply), for: .touchUpInside)
        return agreeBtn
    }()
    
    // MARK: - 生命周期
    init(approvalTaskState:ApprovalTaskState) {
        approvalState = approvalTaskState
        URLProtocol.registerClass(HybridURLProtocol.classForCoder())
        
        HybridURLProtocol.componentType = .MMApprovalManager
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        URLProtocol.wk_registerScheme(scheme: "http")
        URLProtocol.wk_registerScheme(scheme: "https")
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        URLProtocol.wk_unregisterScheme(scheme: "http")
        URLProtocol.wk_unregisterScheme(scheme: "https")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        view .addSubview(progressView)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
//        let url = URL(string: "http://192.168.4.196:3000/approvalInfo.html")
        let url = URL(string: "https://www.baidu.com")

        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 5.0)
        webView.load(request)
        
        self .perform(#selector(test), with: nil, afterDelay: 3)
        self.setFooter()
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    // MARK: -
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //  加载进度条
        if keyPath == "estimatedProgress"{
            progressView.alpha = 1.0
            progressView.setProgress(Float((webView.estimatedProgress) ), animated: true)
            if (webView.estimatedProgress )  >= 1.0 {
                UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseOut, animations: {
                    self.progressView.alpha = 0
                }, completion: { (finish) in
                    self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }

    @objc func test(){
          let js = "calle('22','33')";
                webView.evaluateJavaScript(js) { (response, error) in
                }
    }
    
    @objc func setFooter(){
        //待办审批详情才有底部操作按钮
        if approvalState == .GTasks {
            view.addSubview(footerView)
            footerView.snp.makeConstraints { (maker) in
                maker.left.right.bottom.equalToSuperview()
                maker.height.equalTo(50)
            }
            webView.snp.makeConstraints { (maker) in
                maker.left.right.top.equalToSuperview()
                maker.bottom.equalTo(footerView)
            }
        }
    }
    
    
    // MARK: - footerView Action
    @objc
    func refuseApprovalApply(){
        print("refuse")
        let js = "refuseApproval('applyId')";
        webView.evaluateJavaScript(js) { (response, error) in
//            print(response)
        }
    }
    
    @objc
    func agreeApprovalApply(){
        print("agree")
       //TODO 跳转到同意页面
        let vc = ApprovalWebViewController()
        vc.title = "审批回复"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - appFunc
    //js 调用 跳转审批回复列表
    func appFunc(type:String?,param: NSDictionary?,callback:String?) -> Void {
        print("approvalReplyDetial")
       
        if type == "applyProcess"{
            //pushVC 携带参数 applyId
            let vc = ApprovalWebViewController()
            vc.title = "审批回复"
            navigationController?.pushViewController(vc, animated: true)
        
        }else if type == "applyId"{
            
            webView.evaluateJavaScript("calle('id'=\(approvalId)" ) { (response, error) in
                print(response)
            }
            
        }
        
       
    }
    
    // MARK: - WKScriptMessageHandler
    //js 调用 OC
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        let messageDic: NSDictionary? = message.body as? NSDictionary
        let type: String? = messageDic?["type"] as? String
        let callback: String? = messageDic?["callback"] as? String
        let params: NSDictionary? = messageDic?["params"] as? NSDictionary
        
      
        if message.name == "appFunc" {
            self.appFunc(type: type, param: params, callback: callback)
        }
        
    }
    
    // MARK: - WKUIDelegate
    //js 操作确认弹窗
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print(message)
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
            completionHandler(false)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //操作结果通知
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print(message)
        
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
