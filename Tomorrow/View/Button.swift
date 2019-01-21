//
//  Button.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/10/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class Button: UIButton {    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.App.primary
        self.layer.cornerRadius = 5
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.setTitleColor(UIColor.App.primaryTextActive, for: .highlighted)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font =  UIFont.systemFont(ofSize: 15, weight: .bold)
    }
    
    convenience init(title: String) {
        self.init()
        self.setTitle(title, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
