//
//  Colors.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/9/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

extension UIColor {
    struct App {
        static var background: UIColor  { return UIColor.Hex(hex: "ffffff") }
        static var primary: UIColor  { return UIColor.Hex(hex: "5E40BD") }
        static var primaryText: UIColor  { return UIColor.Hex(hex: "ffffff") }
        static var primaryTextActive: UIColor  { return UIColor.init(red: 1, green: 1, blue: 1, alpha: 0.5) }
        static var text: UIColor  { return UIColor.Hex(hex: "121212") }
        static var lightText: UIColor  { return UIColor.Hex(hex: "5e5e5e") }
        static var inputBg: UIColor  { return UIColor.Hex(hex: "f2f2f2") }
        static var inputPlaceholder: UIColor  { return UIColor.Hex(hex: "777777") }
        static var border: UIColor  { return UIColor.Hex(hex: "dddddd") }
        static var dangerBorder: UIColor  { return UIColor.Hex(hex: "ebcccc") }
        static var dangerText: UIColor  { return UIColor.Hex(hex: "a94442") }
        static var dangerBackground: UIColor  { return UIColor.Hex(hex: "f2dede") }
    }
}

