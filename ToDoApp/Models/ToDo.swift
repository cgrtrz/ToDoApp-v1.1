//
//  Task.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation
import SwiftUICore

struct ToDo : Identifiable, Equatable, Hashable {
    
    var id: UUID
    var title: String
    //var category: Category? = Category(name: "Default", color: Color.indigo, icon: Image(systemName: "list"))
    var description_: String
    var creationDate: TimeInterval
    var completionDate: TimeInterval?
    var dueDate: TimeInterval?
    var isCompleted: Bool = false
    var addedToCalendar: Bool
    var eventId: String? = ""
    
    var hasDueDate: Bool = false
    
    var date: Date {
        return Date(timeIntervalSince1970: dueDate ?? 0)
    }
    
    var overdue: Bool {
    guard let dueDate else { return false }
        return dueDate < Date().timeIntervalSince1970
    }
    
    //MARK: - ATTENTION HERE...
    //TODO: - REVIEW INITS
    init(
        id: UUID,
        title: String,
        description: String,
        creationDate: TimeInterval,
        completionDate: TimeInterval,
        dueDate: TimeInterval,
        isCompleted: Bool,
        addedToCalendar: Bool,
        eventId: String,
        hasDueDate: Bool
    ) {
        self.id = id
        self.title = title
        self.description_ = description
        self.creationDate = creationDate
        self.completionDate = completionDate
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.addedToCalendar = addedToCalendar
        self.eventId = eventId
        self.hasDueDate = hasDueDate
    }
    init(
        title: String,
        description: String,
        creationDate: TimeInterval
        //dueDate: TimeInterval?
    ) {
        self.id = UUID()
        self.title = title
        self.description_ = description
        self.creationDate = creationDate
        //self.dueDate = dueDate
        self.isCompleted = false
        self.addedToCalendar = false
    }
}


