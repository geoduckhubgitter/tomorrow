//
//  NewTaskController.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/9/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit
import AudioToolbox

class NewTaskController: Layout {
    let wrapper = Stack()

    let titleField = Stack(spacing: 5)
    let titleLabel = Label(label: "Task Title")
    let titleInput = Input()
    
    let priorityField = Stack(spacing: 5)
    let priorityLabel = Label(label: "Priority")
    let priorityInput = Range(min: 1, max: 10, value: 5)
    
    let create = Button(title: "Create Task")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navbar title
        navigationItem.title = "New Task"
        
        // Setup view
        setupView()

        // Autohighlight title
        titleInput.becomeFirstResponder()

        // Add create tap event
        create.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(createTap)))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        titleInput.text = ""
        priorityInput.value = 1
        titleInput.defaultColors()
    }
    
    func setupView() {        
        // Add elements to view
        view.addSubview(wrapper)

        titleField.addArrangedSubview(titleLabel)
        titleField.addArrangedSubview(titleInput)
        
        priorityField.addArrangedSubview(priorityLabel)
        priorityField.addArrangedSubview(priorityInput)
        
        wrapper.addArrangedSubview(titleField)
        wrapper.addArrangedSubview(priorityField)
        wrapper.addArrangedSubview(create)
    
        // Set width/margins
        wrapper.fullTopCenter(parent: self)
    }
    
    func validateTitle() -> Bool {
        if let text = titleInput.text {
            // if empty title
            if text.count == 0 {
                // Turn field red
                titleInput.errorColors()
                
                // Vibrate phone
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                
                // Select field
                titleInput.becomeFirstResponder()
                
                // Invalidate
                return false
            }
            
            // Validation passed
            return true
        }
        
        // Not sure how you get here, but invalidate if so
        return false
    }
    
    @objc func createTap() {
        // Fetch form values
        let title = titleInput.text
        let priority = priorityInput.value

        if let title = title {
            // Stop if title doesnt exist
            if !validateTitle() { return }
            
            // Create task
            let task = Task(context: Core.context)
            task.title = title
            task.priority = priority
            task.date = NSDate()
            
            // Save it
            Core.saveContext()
            
            // Send back home
            navigationController?.pushViewController(TasksController(), animated: true)
        }
    }
}
