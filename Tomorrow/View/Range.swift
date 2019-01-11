//
//  Range.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/10/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class Range: UISlider {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.tintColor = UIColor.App.primary
    }
    
    convenience init() {
        self.init(frame: .zero)
        
        self.minimumValue = 1
        self.maximumValue = 5
        self.value = 1
    }
    
    convenience init(min: Float, max: Float, value: Float) {
        self.init(frame: .zero)
        
        self.minimumValue = min
        self.maximumValue = max
        self.value = value
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
