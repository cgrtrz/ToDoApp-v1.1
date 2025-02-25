//
//  DataManager.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 14/12/2024.
//

import Foundation
import SwiftUICore

@MainActor
final class DataManager: ObservableObject {
    
    enum MessageType {
        case addition, deletion, update
    }
    ///Dependency Injection
    ///
    ///`repository` calls `getTaskRepository()` method from `RepositoryManager` singleton where data soures are set.
    private let repository = RepositoryManager.shared.getToDoRepository()
    private let eventManager = EventManager()
    private var toDos: [ToDo] = []
    
    
    @Published var isLoading: Bool = false
    @Published var message: LocalizedStringKey = ""
    @Published var showingMessage = false {
        didSet {
            if showingMessage == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.showingMessage = false
                }
            }
        }
    }
    @Published var toDosCache: [ToDo] = [] //ToDos that view shows.
    {
        didSet {
            print("something changed... \(toDosCache.count)")
        }
    }
    
    init(){
        Task {
            self.getToDos()
        }
    }

    func getToDos() {
        isLoading = true
        toDos = []
        Task {
            do {
                toDos = try await repository.getToDos()
                toDos.sort(by: { $0.creationDate > $1.creationDate })
                toDos.sort(by: { !$0.isCompleted && $1.isCompleted })
                toDosCache = toDos
                isLoading = false
            } catch {
                print(error)
            }
        }
    }

    func addToDo(_ toDo: ToDo) {
        var newTodo = toDo
        //newTodo.eventId = ""
        Task {
            if newTodo.addedToCalendar {
                let eventId = await addToReminder(newTodo)
                newTodo.eventId = eventId
            } else {
                newTodo.eventId = ""
            }
            
            print("Ekleniyor...")
            try await repository.addToDo(newTodo)
            getToDos()
            showMessage(newTodo.title, type: .addition)
        }
    }
    
    func addToReminder(_ toDo: ToDo) async -> String {
        do {
            let eventId = try await eventManager.addToReminder(toDo)
            return eventId
        } catch {
            return ""
        }
    }
    
    func removeFromReminder(_ toDo: ToDo) {
        eventManager.removeFromReminder(toDo.eventId ?? "")
    }
    
    func updateToDo(_ toDo: ToDo) {
        Task {
            do {
                try await repository.updateToDo(toDo)
                print("Guncellendi... \(toDo.eventId ?? "")")
            } catch {}
            //FIXME: CHECK THIS FUNCTION.
            //getToDos()
        }
        toDosCache.removeAll(where: { $0.id == toDo.id })
        toDosCache.append(toDo)
        toDosCache.sort(by: { $0.creationDate > $1.creationDate })
        toDosCache.sort(by: { !$0.isCompleted && $1.isCompleted })
        showMessage(toDo.title, type: .update)
    }
    
    func deleteToDo(_ toDo: ToDo) {
        Task {
            do {
                try await repository.deleteToDo(toDo)
                if toDo.eventId != nil {
                    //eventManager.removeFromCalendar(toDo.eventId ?? "")
                    eventManager.removeFromReminder(toDo.eventId ?? "")
                }
                toDosCache.removeAll { $0.id == toDo.id }
                showMessage(toDo.title, type: .deletion)
                
            } catch {
                //return []
            }
            
        }
    }
    
    func showMessage(_ title: String, type: MessageType) {
        var localTitle = title
        if localTitle.count > 20 {
            localTitle = localTitle.prefix(20) + "..."
        }
        switch type {
        case .addition:
            message = LocalizedStringKey("\(localTitle) has been added!")
        case .deletion:
            message = LocalizedStringKey("\(localTitle) has been deleted!")
        case .update:
            message = LocalizedStringKey("\(localTitle) has been updated!")
        }
        
        showingMessage = true
    }
    
}
