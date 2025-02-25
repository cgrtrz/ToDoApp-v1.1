//
//  TaskListView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import SwiftUI

struct ToDoListView: View {
    
    //TODO: Think about DataManager
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var settingsManager: SettingsManager
    @StateObject var viewModel: ToDoListViewModel = ToDoListViewModel()
    
    //@State var ddd: Bool = false
    
    //FIXME: Delete the lines below.
    //
    
    //FIXME: Set ToDoListType from UserDefaults
    //@State var selectedToDoListType: ToDoListType = .all //No need
    //@State var selectedItem: Int?
    
    //Sheets
    
    
    //FIXME: Find a viable solution.
    //Being used to show popup.
    
    
    
    var body: some View {
        
                //ZStack to switch between ProgressView and ListView...
                ZStack {
                        MainListView(dataManager: _dataManager)
                        //.animation(.interactiveSpring)
                        .overlay (alignment: .bottomTrailing){
                            withAnimation {
                                FloatingNavigationLink {
                                    AddToDoView()
                                }
                                .padding([.bottom, .trailing], 16)
                            }
                            
                        }
                        .toolbar {
                            //SettingsToolbarButton()
                        }
                        .navigationTitle("ToDo App")
                    //2nd View in ZStack, shown if ToDo list is empty.
                    if dataManager.toDosCache.isEmpty && !dataManager.isLoading{
                        ContentUnavailableView("ToDo List is empty", systemImage: "plus", description: Text("Add new item to your ToDo List"))
                    }
                    //3rd View in ZStack, While data is loading, ProgressView rotates...
                    if dataManager.isLoading {
                        ProgressView()
                    }
                    
                    Spacer() //To push content up...
                }//ZStack to switch between ProgressView and ListView...
                .snackbar(isShowing: $dataManager.showingMessage, message: dataManager.message)
    }
}
                 
        

#Preview {
    ToDoListView().environmentObject(DataManager())
        .environmentObject(SettingsManager())
        
}






