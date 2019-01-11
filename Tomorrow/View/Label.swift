//
//  Label.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/10/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class Label: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping

    }
    
    convenience init(label: String) {
        self.init(frame: .zero)
        self.text = label
        self.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        self.textColor = UIColor.App.text
    }
    
    convenience init(_ text: String) {
        self.init(frame: .zero)
        self.text = text
        self.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.textColor = UIColor.App.lightText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
