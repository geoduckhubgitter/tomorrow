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
        
        // Label overrides
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        
        label.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
    
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        
//        container.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        container.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true        
    }
}
