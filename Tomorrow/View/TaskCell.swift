//
//  TaskCell.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/10/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    let label = Label()
    let priority = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupViews() {
        // Edge to edge dividers
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        
        backgroundColor = UIColor.white

        self.addSubview(label)
        self.addSubview(priority)
        
        // Label overrides
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -65).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        label.heightAnchor.constraint(equalToConstant: 70).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        // Setup priority icon
        priority.translatesAutoresizingMaskIntoConstraints = false
        priority.widthAnchor.constraint(equalToConstant: 10).isActive = true
        priority.heightAnchor.constraint(equalToConstant: 10).isActive = true
        priority.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        priority.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        priority.layer.cornerRadius = 5
        
        // Default colror
        priority.backgroundColor = UIColor.HSB(hue: 0, saturation: 50, brightness: 100)
    }
    
    func setPriorityColor(priorityFloat: Float) {
        let saturation = CGFloat(priorityFloat * 10) // 0 - 100
        priority.backgroundColor = UIColor.HSB(hue: 0, saturation: saturation, brightness: 100)
    }
}
