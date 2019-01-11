//
//  SettingsController.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/9/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit

class SettingsController: Layout {
    let wrapper = Stack()
    
    let reset = Stack(spacing: 15)
    let resetInfo = Label("")
    let resetInput = Range(min: 1, max: 24, value: 20)
    let resetLabel = Label(label: "Reset/Reminder Time")
    let resetHour = Label("Selected time: 8pm")
    let save = Button(title: "Save")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Settings"

        setupView()
        
        // Hour change listener
        resetInput.addTarget(self, action:#selector(timeChange), for: .valueChanged)
        
        // Save tap listener
        save.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSave)))
    }
    
    func setupView() {
        resetInfo.text = "This is the time you're daily todos will self destruct and we'll remind you to add tomorrows. We recommand setting this just before your bed time."
        
        // Center hour
        resetHour.textAlignment = .center
        
        // Add elements to view
        view.addSubview(wrapper)
        wrapper.addArrangedSubview(reset)
        reset.addArrangedSubview(resetLabel)
        reset.addArrangedSubview(resetInfo)
        reset.addArrangedSubview(resetInput)
        reset.addArrangedSubview(resetHour)
        wrapper.addArrangedSubview(save)
        
        // Make wrapper full width with margins
        wrapper.fullTopCenter(parent: self)
    }
    
    @objc func timeChange() {
        // Convert military hour to regular time
        let hour = Int(round(resetInput.value))
        var regular:Int
        var ampm: String
        
        if (hour == 24) {
            regular = 12
            ampm = "am"
        } else {
            regular = hour >= 12 ? hour - 12 : hour
            ampm = hour >= 12 ? "pm" : "am"
        }
        
        // Set label
        let hourText = "Selected time: \(regular)\(ampm)"
        resetHour.text = hourText
    }
    
    @objc func handleSave() {
        print("saved!")
    }
}
