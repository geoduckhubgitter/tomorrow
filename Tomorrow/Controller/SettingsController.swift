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
    let savedHour = UserDefaults.standard.float(forKey: "reset")
    var hour:Float = 20
    
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
        if savedHour != 0.0 {
            // Set local hour
            self.hour = savedHour
            
            // Set resetInput value
            self.resetInput.value = self.hour
        }
        
        // Set selected text
        setSelected()
    }
    
    func convertRegularTime(hour: Float) -> String {
        let hour = Int(hour)
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
        // Round and then set local hour
        self.hour = round(resetInput.value)

        // Set selected text
        setSelected()

    }
    
    func setSelected() {
        // Get regular time (ex. 2pm)
        let regular = convertRegularTime(hour: self.hour)
        
        // Set selected text
        selected.text = "Selected time: \(regular)"
    }
    
    @objc func handleSave() {
        // Save it to user default
        UserDefaults.standard.set(resetInput.value, forKey: "reset")
        
        // Redirect home
        navigationController?.pushViewController(TasksController(), animated: true)
    }
}
