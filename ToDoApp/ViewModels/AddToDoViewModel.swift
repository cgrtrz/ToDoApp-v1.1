//
//  AddTaskViewModel.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 14/12/2024.
//

import Foundation

@MainActor
final class AddToDoViewModel: ObservableObject {
    
    private var toDo: ToDo?
    private var dataManager: DataManager = DataManager()
    private var eventManager: EventManager = EventManager()
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var dueDate: Date = Date().addingTimeInterval(60 * 15)
    @Published var showingDatePicker: Bool = false
    @Published var addToCalendar: Bool = false
    @Published var newToDo: ToDo = ToDo(title: "", description: "", creationDate: Date().timeIntervalSince1970)
    
    init() {
        
    }
    
    func addToDo(_ toDo: ToDo) {
        dataManager.addToDo(toDo)
        
        
    }
    
    
    func addNew() {
        if showingDatePicker {
             newToDo = ToDo(id: UUID(),
                               title: title,
                               description: description,
                               creationDate: Date().timeIntervalSince1970,
                            completionDate: 0,
                            dueDate: dueDate.timeIntervalSince1970,
                            isCompleted: false, addedToCalendar: addToCalendar, eventId: "", hasDueDate: showingDatePicker)
        } else {
            newToDo = ToDo(title: title, description: description, creationDate: Date().timeIntervalSince1970)
        }
        
//        if addToCalendar {
//            Task {
//                do {
//                    try await eventManager.addToCalendar(newToDo)
//                    newToDo.addedToCalendar = true
//                } catch {
//                    print(error)
//                }
//            }
//        }
    }
    
}
