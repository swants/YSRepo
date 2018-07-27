//
//  ApprovalTaskFinishCell.swift
//  hybridDemo
//
//  Created by Swants on 2018/7/2.
//  Copyright © 2018年 ctsi. All rights reserved.
//

import UIKit
import MMBase

class ApprovalTaskFinishCell: UITableViewCell {
    private let _avator: UIImageView = {
        let avator = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        avator.layer.cornerRadius = 15
        avator.clipsToBounds = true
        return avator
    }()
    
    private let _nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.colorFromHex(0x333333)
        label.contentCompressionResistancePriority(for: UILayoutConstraintAxis(rawValue: 700)!)
        return label
    }()
    
    private let _timeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.colorFromHex(0x999999)
        label.contentCompressionResistancePriority(for: UILayoutConstraintAxis(rawValue: 900)!)
        return label
    }()
    
    private let _approvalContentLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.colorFromHex(0x333333)
        return label
    }()
    
    private let _stateLabel: UILabel = {
    let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    private let _processLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 12)
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
        contentView.addSubview(_approvalContentLabel)
        contentView.addSubview(_stateLabel)
        contentView.addSubview(_processLabel)
        
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
        
        _approvalContentLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(_nameLabel)
            maker.right.lessThanOrEqualToSuperview().offset(-12)
            maker.top.equalTo(_nameLabel.snp.bottom).offset(12)
        }
        
        _stateLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(_nameLabel)
            maker.top.equalTo(_approvalContentLabel.snp.bottom).offset(20)
            maker.bottom.equalToSuperview().offset(-12)
        }
        
        let tipLabel = UILabel()
        tipLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        tipLabel.text = "当前流转到"
        tipLabel.textColor = UIColor.colorFromHex(0x666666)
        tipLabel.font = UIFont.systemFont(ofSize: 12)
        
        contentView .addSubview(tipLabel)
        tipLabel.snp.makeConstraints { (maker) in
            maker.left.greaterThanOrEqualTo(contentView.snp.centerX).offset(10)
            maker.bottom.equalTo(_stateLabel)
        }
        
        _processLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        _processLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(tipLabel.snp.right).offset(5)
            maker.bottom.equalTo(tipLabel)
            maker.right.equalToSuperview().offset(-12)
        }
        
        //TODO 假数据
        _avator.image = UIImage(named: "avator")
        _nameLabel.text = "外勤火钳刘明"
        _timeLabel.text = "2018-04-21"
        _approvalContentLabel.text = "报销审批申请报销审批申请报销审批申请报销审批申请报销审批申请报销审批申请报销审批申请"
        _stateLabel.text = "同意"
        _processLabel.text = "部门管理员部门管理员部门管理员"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.init()
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
