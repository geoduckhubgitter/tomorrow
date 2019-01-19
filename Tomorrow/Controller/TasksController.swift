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
import UserNotifications

class TasksController: Layout, UITableViewDelegate, UITableViewDataSource {
    // UI Elements
    var archive = false
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
        table.allowsSelectionDuringEditing = true
        table.delegate = self
        table.dataSource = self
        table.fullView(parent: self)
        
        // Retireve tasks
        fetchTasks()
                
        // Refetch on restore
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: nil) { _ in
            self.fetchTasks()
        }
        
        // Update every 2 minutes (So they'll reset if open through reset time)
        Timer.scheduledTimer(timeInterval: 120.0, target: self, selector: #selector(fetchTasks), userInfo: nil, repeats: true)
    }
    
    @objc func fetchTasks() {        
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
        let predicateString = archive ? "date >= %@ && complete == true" : "date >= %@ && complete == false"
        let predicate = NSPredicate(format: predicateString, start as NSDate)
        
        // Add time constraint to fetch request
        fetch.predicate = predicate
        
        // Fetch the tasks
        do {
            self.tasks = try Core.context.fetch(fetch)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Task Actions
    func deleteTask(task: Task) {
        // Delete the task
        Core.context.delete(task)
        
        do {
            // Save changes
            try Core.context.save()
            
            // Delete from local class
            guard let index = self.tasks.firstIndex(of: task) else { return }
            self.tasks.remove(at: index)
            
            // Update table
            table.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func toggleTask(task: Task) {
        // Set it to the oppisite
        task.complete = !task.complete
        
        do {
            // Save changes
            try Core.context.save()
            
            // Delete from local class
            guard let index = self.tasks.firstIndex(of: task) else { return }
            self.tasks.remove(at: index)
            
            // Update table
            table.reloadData()
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let task = tasks[indexPath.row]
        
        if archive {
            let putBack = UITableViewRowAction(style: .normal, title: "Put Back") { (action, indexPath) in
                self.toggleTask(task: task)
            }
            
            let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
                self.deleteTask(task: task)
            }
            
            putBack.backgroundColor = UIColor.App.success
            
            return [putBack, delete]
        } else {
            let archive = UITableViewRowAction(style: .normal, title: "Archive") { (action, indexPath) in
                self.toggleTask(task: task)
            }
        
            archive.backgroundColor = UIColor.App.success
        
            return [archive]
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

