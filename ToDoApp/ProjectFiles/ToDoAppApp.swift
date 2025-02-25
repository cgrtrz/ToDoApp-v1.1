//
//  ToDoAppApp.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import SwiftUI
import CoreData

@main
struct ToDoAppApp: App {
    let persistenceController = PersistenceController.shared
    //let authenticationManager = AuthenticationManager()
    
    var body: some Scene {
        WindowGroup {
            //ContentView()
            NavigationStack {
                ToDoListView()
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
            .environmentObject(DataManager())
            .environmentObject(SettingsManager())
        }
    }
}
