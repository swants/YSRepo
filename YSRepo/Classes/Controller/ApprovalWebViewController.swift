//
//  ApprovalWebViewController.swift
//  hybridDemo
//
//  Created by Swants on 2018/7/4.
//  Copyright © 2018年 ctsi. All rights reserved.
//

import UIKit
import MMBase
import WebKit

class ApprovalWebViewController: BaseViewController, WKNavigationDelegate, WKUIDelegate{
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: view.bounds)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(webView)
        view .addSubview(progressView)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        let url = URL(string: "https://juejin.im/timeline")
        let request = URLRequest(url: url!)
        webView.load(request)
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
