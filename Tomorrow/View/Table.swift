//
//  Table.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/10/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class Table: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Remove extra dividers
        self.tableFooterView = UIView()

    }
    
    convenience init() {
        self.init(frame: .zero, style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fullView(parent: UIViewController) {
        self.heightAnchor.constraint(equalTo: parent.view.heightAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: parent.view.widthAnchor).isActive = true
        self.leftAnchor.constraint(equalTo: parent.view.leftAnchor).isActive = true
        self.topAnchor.constraint(equalTo: parent.view.topAnchor).isActive = true
    }
}
