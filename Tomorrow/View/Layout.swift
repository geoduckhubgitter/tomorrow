//
//  Layout.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/9/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class Layout: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()

        view.backgroundColor = .white
    }
    
    func setupNav() {
        // Set bar colors
        navigationController?.navigationBar.barTintColor = UIColor.App.primary
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.App.primaryText]
        
        // Add right hand buttons
        let settings = UIBarButtonItem(image:  UIImage(named: "settings"), style: .plain, target: self, action: #selector(handleSettingsTap))
        
        let archive = UIBarButtonItem(image:  UIImage(named: "archive"), style: .plain, target: self, action: #selector(handleArchiveTap))

        
        let plus = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(handlePlusTap))
        let tasks = UIBarButtonItem(image: UIImage(named: "tasks"), style: .plain, target: self, action: #selector(handleTasksTap))

        
        self.navigationItem.rightBarButtonItems = [plus, tasks]
        self.navigationItem.leftBarButtonItems = [archive, settings]

        // Disable if active controller
        if navigationController?.topViewController is SettingsController {
            settings.isEnabled = false
        } else if  navigationController?.topViewController is NewTaskController {
            plus.isEnabled = false
        } else if  navigationController?.topViewController is ArchiveController {
            archive.isEnabled = false
        } else if  navigationController?.topViewController is TasksController {
            tasks.isEnabled = false
        }
    }

    @objc func handlePlusTap() {
        navigationController?.pushViewController(NewTaskController(), animated: true)
    }
    
    @objc func handleSettingsTap() {
        navigationController?.pushViewController(SettingsController(), animated: true)
    }
    
    @objc func handleTasksTap() {
        navigationController?.pushViewController(TasksController(), animated: true)
    }
    
    @objc func handleArchiveTap() {
        navigationController?.pushViewController(ArchiveController(), animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
}
