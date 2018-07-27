//
//  SegumentView.swift
//  hybridDemo
//
//  Created by Swants on 2018/6/29.
//  Copyright © 2018年 ctsi. All rights reserved.
//

import UIKit
import MMBase

protocol SegumentViewProtocol {
    func changeIndexAction(index: NSInteger) -> Void
}

class SegumentView: UIView {
    public var delegte: SegumentViewProtocol? = nil
    public var SelectTitleColor:UIColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    public var TitleColor:UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    public var lineColor:UIColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    
    private let btnArray =  NSMutableArray()
    private var selectorBtn :UIButton = UIButton()
    private let indictorLine :UIView = UIView()
    
 
    convenience init(frame:CGRect, titles:[String]){
       self.init(frame: frame)
    
       self.setupTitle(titles)
       self.addBottomLine()
       self.addIndictorLine()
    
    }
    
    func setupTitle(_ titles:[String]) -> Void {
        
        var index = 0
        for string in titles {
            
            let btn = UIButton()
            
            btn.setTitle(string, for: .normal)
            btn.setTitleColor(TitleColor, for: .normal)
            btn.setTitleColor(SelectTitleColor, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.tag = index
            btn.addTarget(self, action: #selector(selectAction(sender:)), for: .touchUpInside)
            
            if index == 0 {
                btn.isSelected = true
            }
            
            self.addSubview(btn)
            let btnWidth = self.bounds.size.width / CGFloat(titles.count)
            let btnHeight = self.bounds.size.height
            btn.frame = CGRect(origin: CGPoint(x: CGFloat(index) * btnWidth, y: self.bounds.origin.y), size: CGSize(width: btnWidth, height: btnHeight))
            
            btnArray.add(btn)
            self.addSubview(btn)
            
           index += 1
        }
    }
    
    @objc func selectAction(sender:UIButton) ->Void{
        for btn in btnArray {
            let currentBtn :UIButton = btn as! UIButton
            currentBtn.isSelected = false;
        }
        
        sender.isSelected = true
        selectorBtn = sender
      
        UIView.animate(withDuration: 0.2) {
            self.indictorLine.frame = CGRect(origin: CGPoint(x: sender.frame.origin.x, y: self.bounds.size.height-2),size: self.indictorLine.bounds.size)
        }
        
        delegte?.changeIndexAction(index: sender.tag)
        
    }
    
    func addBottomLine() -> Void {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.addSubview(line)
        line.frame = CGRect(x: 0, y: self.bounds.size.height-1, width: self.bounds.size.width, height: 1)
    }
    
    func addIndictorLine() -> Void {
        let lineWidth = self.bounds.size.width / CGFloat(btnArray.count)
        indictorLine.frame = CGRect(x: 0, y: self.bounds.size.height-2, width: lineWidth, height: 2)
        
        indictorLine.backgroundColor = lineColor
        self.addSubview(indictorLine)
    }
}
