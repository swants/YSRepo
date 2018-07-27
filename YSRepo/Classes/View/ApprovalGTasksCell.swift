//
//  ApprovalGTasksCell.swift
//  hybridDemo
//
//  Created by Swants on 2018/7/2.
//  Copyright © 2018年 ctsi. All rights reserved.
//

import UIKit
import SnapKit
import MMBase

class ApprovalGTasksCell: UITableViewCell {
    private var _avator: UIImageView = {
        let avator = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        avator.layer.cornerRadius = 15
        avator.clipsToBounds = true
        return avator
    }()
    
    private var _nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.colorFromHex(0x333333)
        label.contentCompressionResistancePriority(for: UILayoutConstraintAxis(rawValue: 700)!)
        return label
    }()
    
    private var _timeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.colorFromHex(0x999999)
        label.contentCompressionResistancePriority(for: UILayoutConstraintAxis(rawValue: 900)!)
        return label
    }()
    
    private var _ApprovalContentLabel: UILabel = {
       var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.colorFromHex(0x333333)
        return label
    }()
    
    
    // MARK: -  init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        self.accessoryType = .none
        self.selectionStyle = .none
        self.contentView.addSingleBorder(direct: .bottom, color: UIColor.colorFromHex(0xeeeeee), width: 0.5)
        
        contentView.addSubview(_avator)
        contentView.addSubview(_nameLabel)
        contentView.addSubview(_timeLabel)
        contentView.addSubview(_ApprovalContentLabel)

        _avator.snp.makeConstraints { (maker) in
            maker.top.left.equalToSuperview().offset(12)
            maker.width.height.equalTo(30)
        }
        
        _nameLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(_avator.snp.right).offset(5)
            maker.centerY.equalTo(_avator)
            maker.right.lessThanOrEqualTo(_timeLabel.snp.left).offset(10)
        }
        
        _timeLabel.snp.makeConstraints { (maker) in
            maker.right.equalToSuperview().offset(-12)
            maker.top.equalTo(_nameLabel)
        }
        
        _ApprovalContentLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(_nameLabel)
            maker.right.lessThanOrEqualToSuperview().offset(-12)
            maker.top.equalTo(_nameLabel.snp.bottom).offset(12)
            maker.bottom.equalToSuperview().offset(-12)
        }
        
        //TODO
        _avator.image = UIImage(named: "avator")
        _nameLabel.text = "外勤刘明"
        _timeLabel.text = "2018-04-21"
        _ApprovalContentLabel.text = "报销审批申请"
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
