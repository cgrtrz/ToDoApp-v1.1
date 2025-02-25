//
//  MockNetworkTaskRepository.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 11/12/2024.
//

import Foundation

///Mimicks network connection with 1 sec delays and provides dummy data.
final class MockedNetworkToDoRepository: ToDoRepository {
 
    
    
    private var toDos: [ToDo] = [
        ToDo(id: UUID(), title: "Task 1", description: "Task 1 description", creationDate: Date().timeIntervalSince1970, completionDate: 0, dueDate: 0, isCompleted: false, addedToCalendar: true, eventId: "", hasDueDate: false),
        ToDo(title: "Task 2", description: "Task 2 description", creationDate: Date().timeIntervalSince1970),
        ToDo(id: UUID(), title: "Task 3", description: "Task 3 description", creationDate: Date().timeIntervalSince1970, completionDate: 0, dueDate: 0, isCompleted: true, addedToCalendar: true, eventId: "", hasDueDate: false),
        ToDo(title: "Task 4", description: "Task 4 description", creationDate: Date().timeIntervalSince1970),
        ToDo(id: UUID(), title: "Task 5", description: "Task 5 description", creationDate: Date().timeIntervalSince1970, completionDate: 0, dueDate: 0, isCompleted: false, addedToCalendar: true, eventId: "", hasDueDate: false),
        ToDo(id: UUID(), title: "Task 6", description: "Task 6 description", creationDate: Date().timeIntervalSince1970, completionDate: 0, dueDate: 0, isCompleted: false, addedToCalendar: true, eventId: "", hasDueDate: false)]
    
    func getToDos() async throws -> [ToDo] {
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 1)
        return toDos
    }
    
    func addToDo(_ toDo: ToDo) async throws {
        //try await Task.sleep(nanoseconds: NSEC_PER_SEC * UInt64(0.6))
        toDos.append(toDo)
    }
    
    func updateToDo(_ toDo: ToDo) async throws {
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * UInt64(0.6))
        try await deleteToDo(toDo)
        try await addToDo(toDo)
    }
    
    func deleteToDo(_ toDo: ToDo) async throws {
        try await Task.sleep(nanoseconds: NSEC_PER_SEC * 2)
        if let index = getArrayIndex(toDo) {
            toDos.remove(at: index)
            print("deleted..........")
        } else {
            throw TaskRepositoryError.taskNotFound
        }
    }
    
    func getArrayIndex(_ toDo: ToDo) -> Int? {
        return toDos.firstIndex(where: { $0.id == toDo.id })
    }
    
    
}
