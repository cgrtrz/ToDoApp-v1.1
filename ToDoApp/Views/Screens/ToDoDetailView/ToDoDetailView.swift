//
//  TaskDetailView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import SwiftUI

struct ToDoDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var settingsManager: SettingsManager
    @EnvironmentObject var dataManager: DataManager
    @StateObject var viewModel: ToDoDetailViewModel = ToDoDetailViewModel()
    @State var toDo: ToDo
    
    //@State private var dueDate: Date = Date()
    //@State private var isEditing: Bool = false
    @State private var dueDate: Date = Date() //{
    @State private var isShowingCalendar: Bool = false
    @State private var hasDueDate: Bool = false
    
   
    
    var body: some View {
        
        
        NavigationView {
            VStack {
                List {
                    TitleView(title: $toDo.title, description_: $toDo.description_)
                    Section {
                        HStack {
                            Image(systemName: "calendar")
                                .frame(width: 32, height:32)
                            VStack (alignment: .leading){
                                Text("Due date")
                                if toDo.hasDueDate {
                                    Button {
                                        withAnimation{
                                            isShowingCalendar.toggle()
                                        }
                                        } label: {
                                        Text("\(Date(timeIntervalSince1970: toDo.dueDate ?? 0).formatted(date: .abbreviated, time: .shortened))")
                                            .font(.caption)
                                            .foregroundStyle(.blue)
                                    }
                                }
                            }
                            Spacer()
                           
                            Toggle(isOn: $hasDueDate.animation()) {
                                
                            }.onChange(of: hasDueDate) { oldValue, newValue in
                                isShowingCalendar = hasDueDate
                                if toDo.hasDueDate {
                                    if newValue == false {
                                        toDo.dueDate = 0
                                        dueDate = Date(timeIntervalSince1970: toDo.dueDate ?? 0)
                                        if toDo.eventId != "" {
                                            dataManager.removeFromReminder(toDo)
                                            toDo.eventId = ""
                                        }
                                        dataManager.updateToDo(toDo)
                                    }
                                } else {
                                    if newValue == true {
                                        toDo.dueDate = dueDate.timeIntervalSince1970
                                    }
                                }
                            }
                            
                            
                        }
                        if isShowingCalendar {
                            
                            DatePicker(selection: $dueDate, in: Date().addingTimeInterval(60 * 15)...) {}
                            .datePickerStyle(.graphical)
                            .id(dueDate)
                            .transition(.slide)
                            
                            HStack {
                                BellImageView(showWaves: $toDo.addedToCalendar)
                                Text("Add to calendar")
                                Spacer()
                                Toggle(isOn: $toDo.addedToCalendar){}
                                    .onChange(of: toDo.addedToCalendar) { oldValue, newValue in
                                        if oldValue == true && newValue == false {
                                            Task {
                                                toDo.addedToCalendar = false
                                                dataManager.removeFromReminder(toDo)
                                                toDo.eventId = ""
                                                dataManager.updateToDo(toDo)
                                            }
                                        } else if oldValue == false && newValue == true {
                                            toDo.addedToCalendar = true
                                            Task {
                                                let eventId = await dataManager.addToReminder(toDo)
                                                if eventId != "" {
                                                    toDo.eventId = eventId
                                                    dataManager.updateToDo(toDo)
                                                }
                                            }
                                        }
                                    }
                            }
                            
                        }
                        else {
                            //If due date is set.
                            if toDo.hasDueDate {
                                //If due date is set and added to the calendar.
                                if toDo.addedToCalendar {
                                    HStack {
                                        BellImageView(showWaves: $toDo.addedToCalendar)
                                        Text("Added to calendar")
                                            .font(.caption)
                                            .italic()
                                            .foregroundStyle(Color(.secondaryLabel))
                                        Spacer()
                                        Button {
                                            Task {
                                                toDo.addedToCalendar = false
                                                dataManager.removeFromReminder(toDo)
                                                toDo.eventId = ""
                                                dataManager.updateToDo(toDo)
                                            }
                                        } label: {
                                            Text("REMOVE")
                                                .font(.caption)
                                        }
                                        .underline()
                                        .buttonStyle(.borderless)
                                        .tint(Color.red)
                                    }
                                }
                                //If due date is set and NOT added to the calendar.
                                else {
                                    HStack (alignment: .center){
                                        Spacer()
                                        Button {
                                            toDo.addedToCalendar = true
                                            Task {
                                                let eventId = await dataManager.addToReminder(toDo)
                                                if eventId != "" {
                                                    toDo.eventId = eventId
                                                    dataManager.updateToDo(toDo)
                                                }
                                            }
                                        } label: {
                                            Text("ADD TO CALENDAR")
                                                .font(.caption)
                                                .foregroundStyle(.blue)
                                        }
                                        .buttonStyle(.bordered)
                                        
                                    }
                                }
                                
                                //If due date is NOT set at all.
                            }
                        }
                    }
                }
                //.listStyle(.plain)
                .scrollContentBackground(.hidden)
                .onAppear{
                    guard let newDueDate = toDo.dueDate else { return }
                    if newDueDate == 0 {
                        self.dueDate = Date(timeIntervalSince1970: Date().timeIntervalSince1970 + 900)
                        self.hasDueDate = false
                    } else {
                        self.dueDate = Date(timeIntervalSince1970: newDueDate)
                        self.hasDueDate = true
                    }
                    
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                
                FooterView(creationDate: $toDo.creationDate, completionDate: $toDo.completionDate)
                
                
                Button {
                    toDo.dueDate = dueDate.timeIntervalSince1970
                    Task {
                        if toDo.eventId != "" {
                            dataManager.removeFromReminder(toDo)
                            toDo.eventId = ""
                            let eventId = await dataManager.addToReminder(toDo)
                            if eventId != "" {
                                toDo.eventId = eventId
                            }
                            
                        }
                        dataManager.updateToDo(toDo)
                        dismiss()
                    }
                } label: {
                    ButtonLabel(text: "UPDATE", width: nil)
                }
                .disabled(toDo.title.isEmpty)
                .padding(16)
                
                
                
                
            }
            //Spacer()
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                    dataManager.deleteToDo(toDo)
                } label: {
                    HStack {
                        //Text("DELETE")
                        Image(systemName: "trash.fill")
                    }.foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    ToDoDetailView(toDo: ToDo(title: "Title", description: "Description", creationDate: 0))
        .environmentObject(DataManager())
        .environmentObject(SettingsManager())
}

struct TitleView: View {
    
    @Binding var title: String
    @Binding var description_: String
    
    var body: some View {
        Section {
            TextField("Title", text: $title, axis: .vertical)
                .font(.largeTitle)
                .multilineTextAlignment(.leading)
                .lineLimit(10)
            TextField("Description", text: $description_, axis: .vertical)
                .lineLimit(2...)
        }
    }
}

struct FooterView: View {
    
    @Binding var creationDate: TimeInterval
    @Binding var completionDate: TimeInterval?
    
    var body: some View {
        VStack (alignment: .leading){
            HStack {
                Image(systemName: "pencil.and.list.clipboard")
                    .foregroundStyle(Color.gray)
                    .frame(width: 32, height:32)
                Text("Created on \(Date(timeIntervalSince1970: creationDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.caption)
                    .italic()
                    .foregroundStyle(Color(.secondaryLabel))
            }
            if completionDate != 0 {
                HStack {
                    Image(systemName:  "checkmark.circle.fill")
                        .foregroundStyle(Color.green)
                        .frame(width: 32, height:32)
                    Text("Completed on \(Date(timeIntervalSince1970: completionDate ?? 0).formatted(date: .abbreviated, time: .shortened))")
                        .font(.caption)
                        .italic()
                        .foregroundStyle(Color(.secondaryLabel))
                }
            }
        }.padding()
    }
}

struct BellImageView: View {
    
    @Binding var showWaves: Bool
    
    var body: some View {
        if showWaves {
            Image(systemName: "bell.and.waves.left.and.right.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(.yellow, .secondary)
                //.frame(width: 32, height:32)
                .font(.title2)
        }
        else {
            Image(systemName: "bell.fill")
                .foregroundStyle(.yellow)
                .font(.title2)
        }
    }
}
