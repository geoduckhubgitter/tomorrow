//
//  Input.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/10/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class Input: UITextField  {
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.font = UIFont.systemFont(ofSize: 15)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.size.height))
        self.rightView = padding
        self.rightViewMode = .always
        self.leftView = padding
        self.leftViewMode = .always
        
        defaultColors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func errorColors() {
        self.textColor = UIColor.App.dangerText
        self.backgroundColor = UIColor.App.dangerBackground
        self.layer.borderColor = UIColor.App.dangerBorder.cgColor
    }
    
    func defaultColors() {
        self.textColor = UIColor.App.text
        self.backgroundColor = UIColor.App.inputBg
        self.layer.borderColor = UIColor.App.border.cgColor
    }
}
