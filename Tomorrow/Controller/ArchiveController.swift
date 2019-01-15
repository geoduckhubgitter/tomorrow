//
//  ArchiveController.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/14/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import Foundation

class ArchiveController: TasksController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        
        super.archive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
