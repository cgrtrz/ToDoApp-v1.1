//
//  TaskListViewModel.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation
import SwiftUI

@MainActor
final class ToDoListViewModel : ObservableObject {
    
    //Data Manager
//    private var dataManager: DataManager = DataManager()
//    
//    //Publish these so that views can use.
//    @Published var toDosCache: [ToDo] = [] //ToDos that view shows.
//    {
//        didSet {
//            print("something changed... \(toDosCache.count)")
//        }
//    }
//    
//    private var toDos: [ToDo] = []
    
    //@Published var isLoading: Bool = false //To rotate ProgressView while data is loading.
    @Published var showingAddToDoSheet = false
    @Published var showingSettingsSheet = false
//    @Published var message = ""
//    @Published var showingMessage = false {
//        didSet {
//            if showingMessage == true {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    self.showingMessage = false
//                }
//            }
//        }
//    }
    
    init() {

       // self.getToDos()
        //print("viewModel instantiated")
       
        
    }
    
    //Get ToDos from DataManager and assign them to ToDos Array.
    func getToDos() {
//        isLoading = true //View shows ProgressView
//        print("started......")
//        //FIXME: Check this line.
//        toDosCache = []
//        toDos = []
//        
//        Task {
//            //toDos = await dataManager.getToDos()
////            toDos.sort(by: { $0.creationDate > $1.creationDate })
////            toDos.sort(by: { !$0.isCompleted && $1.isCompleted })
////            toDosCache = toDos
////            isLoading = false //After ToDos are assigned to array, ProgressView disappears.
//        }
    }
        
//    func addToDo(_ toDo: ToDo) {
//        Task {
//            dataManager.addToDo(toDo)
//            getToDos()
//            message = "New ToDo added: \(toDo.title)"
//            showingMessage = true
//        }
//    }
    
//    func updateToDo(_ toDo: ToDo) {
//        Task {
//            dataManager.updateToDo(toDo)
//            
//            //getToDos()
//        }
//        toDosCache.removeAll(where: { $0.id == toDo.id })
//        toDosCache.append(toDo)
//        toDosCache.sort(by: { $0.creationDate > $1.creationDate })
//        toDosCache.sort(by: { !$0.isCompleted && $1.isCompleted })
//    }
    
    //FIXME: Reconsider this func
//    func deleteToDo(_ toDo: ToDo) {
//        Task {
//            dataManager.deleteToDo(toDo)
//            //await print(aaa.value.count)
//            print("deleting......")
//            //getToDos()
//            toDosCache.removeAll { $0.id == toDo.id }
//            message = "\(toDo.title) has been deleted!"
//            showingMessage = true
//        }
//        
//    
//    }
}
