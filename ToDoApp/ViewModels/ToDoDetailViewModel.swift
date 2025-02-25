//
//  ToDoDetailViewModel.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 02/01/2025.
//
import Foundation

final class ToDoDetailViewModel: ObservableObject {
    
    let eventManager: EventManager = EventManager()
    
    @Published var showingDatePicker: Bool = false
    @Published var addToCalendar: Bool = false
    @Published var dueDate: Date = Date()
    
    func removeFromReminders(_ reminderId: String) {
        
        eventManager.removeFromReminder(reminderId)
    }
    
//    func addToReminder(_ toDo: ToDo) {
//        
//        Task {
//            try await eventManager.addToReminder(toDo)
//        }
//    }
}
