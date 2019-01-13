//
//  Hsb.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/13/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit


extension UIColor {
    static func HSB(hue: CGFloat, saturation: CGFloat, brightness: CGFloat) -> UIColor {
        return UIColor(hue: hue/360, saturation: saturation/100, brightness: brightness/100, alpha: 1)
    }
}
