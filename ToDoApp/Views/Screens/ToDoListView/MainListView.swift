//
//  MainListView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 05/01/2025.
//
import SwiftUI
import StoreKit

struct MainListView: View {
    
    @EnvironmentObject var dataManager: DataManager
    @Environment(\.requestReview) private var requestReview
    
    var body: some View {
        
        List {
            
            ForEach(dataManager.toDosCache, id: \.self) { toDo in
                
                NavigationLink {
                    ToDoDetailView2(toDo)
                } label: {
                    ToDoRowView(toDo: toDo)
                }
                
            }
            
            .onDelete { indexSet in
                if let index = indexSet.first {
                    dataManager.deleteToDo(dataManager.toDosCache[index])
                }
            }
            
        }// List (main ToDo List)
        .listStyle(.plain)
        .refreshable {
            dataManager.getToDos()
        }
        .onAppear {
            
            let numberOfAppLaunches = UserDefaults.standard.integer(forKey: "numberOfAppLaunches")
            
            UserDefaults.standard.set(numberOfAppLaunches + 1, forKey: "numberOfAppLaunches")
            
            if numberOfAppLaunches > 5 {
                requestReview()
                UserDefaults.standard.set(0, forKey: "numberOfAppLaunches")
            }
        }
        //.animation(.interactiveSpring(duration: 0.1))
    }
}
