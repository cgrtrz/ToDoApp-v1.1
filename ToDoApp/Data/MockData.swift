//
//  MockTasksData.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation

struct MockData {
    
    static var shared = MockData()
    
    var tasks: [ToDo]
    init() {
        print("\(Date().formatted(date: .abbreviated, time: .standard)) - MockData initialized")
        tasks = [
            ToDo(id: UUID(), title: "Task 1", description: "Task 1 description", creationDate: Date().timeIntervalSince1970, completionDate: 0, dueDate: 0, isCompleted: false, addedToCalendar: true, eventId: "", hasDueDate: false),
            ToDo(title: "Task 2", description: "Task 2 description", creationDate: Date().timeIntervalSince1970),
            ToDo(id: UUID(), title: "Task 3", description: "Task 3 description", creationDate: Date().timeIntervalSince1970, completionDate: 0, dueDate: 0, isCompleted: true, addedToCalendar: true, eventId: "", hasDueDate: false),
            ToDo(title: "Task 4", description: "Task 4 description", creationDate: Date().timeIntervalSince1970),
            ToDo(id: UUID(), title: "Task 5", description: "Task 5 description", creationDate: Date().timeIntervalSince1970, completionDate: 0, dueDate: 0, isCompleted: false, addedToCalendar: true, eventId: "", hasDueDate: false),
            ToDo(id: UUID(), title: "Task 6", description: "Task 6 description", creationDate: Date().timeIntervalSince1970, completionDate: 0, dueDate: 0, isCompleted: false, addedToCalendar: true, eventId: "", hasDueDate: false)]
        
        
            }
}
