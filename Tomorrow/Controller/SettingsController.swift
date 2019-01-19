//
//  SettingsController.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/9/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class SettingsController: Layout {
    // Elements
    let wrapper = Stack()
    let reset = Stack(spacing: 15)
    let resetInfo = Label("")
    let resetInput = Range(min: 1, max: 24, value: 20)
    let resetLabel = Label(label: "Reset/Reminder Time")
    let selected = Label("")
    let save = Button(title: "Save")
    
    // Settings
    let resetTime = UserDefaults.standard.float(forKey: "reset")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set nav title
        navigationItem.title = "Settings"

        // Add elements to view
        setupView()
        
        // Set Settings
        setSettings()

        // Hour change listener
        resetInput.addTarget(self, action:#selector(handleResetChange), for: .valueChanged)
        
        // Save tap listener
        save.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSave)))
    }
    
    func setupView() {
        resetInfo.text = "This is the time you're daily todos will self destruct and we'll remind you to add tomorrows. We recommand setting this just before your bed time."
        
        // Center hour
        selected.textAlignment = .center
        
        // Add elements to view
        view.addSubview(wrapper)
        wrapper.addArrangedSubview(reset)
        reset.addArrangedSubview(resetLabel)
        reset.addArrangedSubview(resetInfo)
        reset.addArrangedSubview(resetInput)
        reset.addArrangedSubview(selected)
        wrapper.addArrangedSubview(save)
        
        // Make wrapper full width with margins
        wrapper.fullTopCenter(parent: self)
    }
    
    func setSettings() {
        // Set resetInput value
        resetInput.value = resetTime
        
        // Set selected text
        setSelected()
    }
    
    func convertRegularTime(hour: Float) -> String {
        let hour = Int(round(hour))
        var regular:Int
        var ampm: String
        
        if (hour == 24) {
            regular = 12
            ampm = "am"
        } else {
            regular = hour > 12 ? hour - 12 : hour
            ampm = hour >= 12 ? "pm" : "am"
        }
        
        return "\(regular)\(ampm)"
    }
    
    @objc func handleResetChange() {
        // Set selected text
        setSelected()
    }
    
    func setSelected() {
        // Get regular time (ex. 2pm)
        let regular = convertRegularTime(hour: resetInput.value)
        
        // Set selected text
        selected.text = "Selected time: \(regular)"
    }
    
    @objc func handleSave() {
        // Round to hour
        let rounded = round(resetInput.value)
        
        // Save it to user default
        UserDefaults.standard.set(rounded, forKey: "reset")
        
        // Update notification
        Notify.shared.createNotification(hour: rounded)
        
        // Redirect home
        navigationController?.pushViewController(TasksController(), animated: true)
    }
}
