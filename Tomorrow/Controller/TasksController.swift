//
//  TasksController.swift
//  Tomorrow
//
//  Created by Robby Klein on 1/9/19.
//  Copyright © 2019 Robby Klein. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class TasksController: Layout, UITableViewDelegate, UITableViewDataSource {
    // UI Elements
    let label = UILabel()
    let table = Table()
    var tasks = [Task]()
    let cellId = "taskCell"
    
    // Settings
    let resetTime = UserDefaults.standard.float(forKey: "reset")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(table)
    
        // Setup navbar
        navigationItem.title = "Tasks"
    
        // Tableview Settings
        table.register(TaskCell.self, forCellReuseIdentifier: cellId)
        table.delegate = self
        table.dataSource = self
        table.fullView(parent: self)
        
        // Retireve tasks
        fetchTasks()
    }
    
    func fetchTasks() {
        // The fetch request
        let fetch:NSFetchRequest = Task.fetchRequest()
        
        // Sort by priority and date
        let priority = NSSortDescriptor(key: #keyPath(Task.priority), ascending: false)
        let date = NSSortDescriptor(key: #keyPath(Task.date), ascending: false)
        fetch.sortDescriptors = [priority, date]

        // Create and set calender object to their local time
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        // Which hour are they on
        let hours = calendar.component(.hour, from: Date())
        
        // Is it passed the reset time?
        let tomorrow = Int(resetTime) <= hours
        
        // Beginning of today
        let today = calendar.startOfDay(for: Date())
        
        // Whats added to start of day to get start time
        let addition = tomorrow ? Int(resetTime) : Int((24 - resetTime) * -1)
        
        // Create a start date for query
        guard let start = calendar.date(byAdding: .hour, value: addition, to: today) else { return }
        
        // All tasks after start time
        let datePredicate = NSPredicate(format: "date > %@", start as NSDate)
        
        // Add time constraint to fetch request
        fetch.predicate = datePredicate
        
        // Fetch the tasks
        do {
            self.tasks =  try Core.context.fetch(fetch)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Table View  Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TaskCell
        let row = indexPath.row
        let task = tasks[row]
            
        cell.label.text = task.title
        cell.setPriorityColor(priorityFloat: task.priority)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

