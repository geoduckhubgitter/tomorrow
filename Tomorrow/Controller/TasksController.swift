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
        // Sort by priority
        let task:NSFetchRequest = Task.fetchRequest()
        let order = NSSortDescriptor(key: #keyPath(Task.priority), ascending: false)
        task.sortDescriptors = [order]

        // Get tasks within 24 hour period
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        let today = calendar.startOfDay(for: Date())
        guard let start = calendar.date(byAdding: .hour, value: 17, to: today) else { return }
        guard let end = calendar.date(byAdding: .day, value: 1, to: start) else { return }

        let datePredicate = NSPredicate(format: "date > %@", start as NSDate)
        task.predicate = datePredicate
        
        
        do {
            self.tasks =  try Core.context.fetch(task)
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}

