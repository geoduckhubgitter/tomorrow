//
//  Textarea.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/10/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class Textarea: UITextView, UITextViewDelegate {
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.font = UIFont.systemFont(ofSize: 15)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        self.textColor = UIColor.App.text
        self.backgroundColor = UIColor.App.inputBg
        self.layer.borderColor = UIColor.App.border.cgColor
    }
    
    convenience init() {
        self.init(frame: .zero, textContainer: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
