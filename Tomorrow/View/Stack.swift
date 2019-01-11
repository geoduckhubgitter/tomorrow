//
//  Stackview.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/9/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class Stack: UIStackView {
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = .vertical
        self.spacing = 15
    }
    
    convenience init(spacing: CGFloat) {
        self.init()
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fullTopCenter(parent: UIViewController) {
        self.widthAnchor.constraint(equalTo: parent.view.widthAnchor, constant: -40).isActive = true
        self.topAnchor.constraint(equalTo: parent.view.topAnchor, constant: 20).isActive = true
        self.centerXAnchor.constraint(equalTo: parent.view.centerXAnchor).isActive = true
    }

}
