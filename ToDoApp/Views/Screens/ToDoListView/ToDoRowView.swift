//
//  TaskListRowView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import SwiftUI

struct ToDoRowView: View {
    
    @EnvironmentObject var dataManager: DataManager
    @State var toDo: ToDo
    
    var body: some View {
        
        HStack {
            Toggle("some text", isOn: $toDo.isCompleted)
                .toggleStyle(ToDoToogleStyle())
                .onChange(of: toDo.isCompleted) { _, _ in
                    if toDo.isCompleted {
                        toDo.completionDate = Date().timeIntervalSince1970
                    } else {
                        toDo.completionDate = 0
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        dataManager.updateToDo(toDo)
                    }
                }
            Text(toDo.title)
                .font(.headline)
                .lineLimit(2)
                .foregroundStyle(toDo.isCompleted ? Color.gray : Color.primary)
                .strikethrough(toDo.isCompleted)
            Spacer()
            if toDo.hasDueDate {
                Image(systemName: "calendar")
                    .foregroundStyle(Color.secondary)
            }
            if toDo.addedToCalendar{
                Image(systemName: "bell.and.waves.left.and.right.fill")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.yellow, .secondary)
            }
            Text(!toDo.isCompleted && toDo.hasDueDate && toDo.overdue ? "!" :"")
                .foregroundStyle(Color.red)
            
        }
        
        
    }
}
//
//#Preview {
//    TaskListRowView()
//}
