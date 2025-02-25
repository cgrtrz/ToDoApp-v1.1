//
//  ToDoDetailView2.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 04/01/2025.
//

import SwiftUI

struct ToDoDetailView2: View {
    
    enum Field {
        case title
        case description
    }
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var dataManager: DataManager
    //@EnvironmentObject private var eventManager: EventManager
    @FocusState private var focusedField: Field?
    @State var toDo: ToDo
    @State private var copyToDo: ToDo
    
    @State private var dueDate: Date = Date() {
        didSet {
            if toDo.hasDueDate{
                toDo.dueDate = dueDate.timeIntervalSince1970
            }
            //print(dueDate.description)
        }
    }
    @State private var isModified: Bool = false
    @State private var showingConfirmationDialog: Bool = false
    @State private var showingDate: Bool = false
    @State private var showingFullDescription: Bool = false
    
    
   
    
    private let bottomId = 1500
    
    init(_ toDo: ToDo) {
        self.toDo = toDo
        self.copyToDo = toDo
        if !toDo.hasDueDate {
            self.dueDate = Date()
        }
        else {
            self.dueDate = Date(timeIntervalSince1970: toDo.dueDate ?? 0)
        }
    }
    
    
    
    var body: some View {
        
        ScrollViewReader { proxy in
            List {
                
                Section {
                    TextField("Title", text: $toDo.title, axis: .vertical)
                        .font(.title)
                        .bold()
                        .focused($focusedField, equals: .title)
                        .toolbar {
                            ToolbarItem (placement: .keyboard) {
                                HStack {
                                    Spacer()
                                    Button {
                                        focusedField = nil
                                    } label: {
                                        Text("Close")
                                    }
                                }
                            }
                        }
                    TextField("Description", text: $toDo.description_, axis: .vertical)
                        .lineLimit(showingFullDescription ? 100 : 2)
                        .truncationMode(.tail)
                        .focused($focusedField, equals: .description)
                        .onChange(of: focusedField) { oldValue, newValue in
                            switch focusedField {
                            case .title:
                                showingFullDescription = false
                            case .description:
                                showingFullDescription = true
                            case nil:
                                showingFullDescription = false
                            }
                        }
                }
                
                Section {
                    HStack {
                        Image(systemName: "calendar")
                            .font(.title2)
                        VStack (alignment: .leading){
                            Text(toDo.hasDueDate ? "Date added" : "Add date")
                            if toDo.hasDueDate && !showingDate {
                                Button {
                                    
                                    focusedField = nil
                                    showingDate.toggle()
                                    proxy.scrollTo(bottomId)
                                    
                                } label: {
                                    Text(dueDate.formatted(date: .numeric, time: .shortened))
                                        .font(.caption)
                                        .foregroundStyle(.blue)
                                }
                            }
                                
                            
                        }
                        Spacer()
                        Toggle("", isOn: $toDo.hasDueDate)
                            .onChange(of: toDo.hasDueDate) { _, newValue in
                                
                                focusedField = nil
                                
                                if newValue == true {
                                    showingDate = true
                                    //proxy.scrollTo(bottomId)
                                    toDo.dueDate = dueDate.timeIntervalSince1970
                                } else {
                                    toDo.dueDate = 0
                                    toDo.addedToCalendar = false
                                    showingDate = false
                                }
                                proxy.scrollTo(bottomId, anchor: .top)
                            }
                            
                    }
                    if showingDate{
                        
                        DatePicker("", selection: $dueDate, in: Date()...)
                            .id(dueDate.addingTimeInterval(900))
                            .datePickerStyle(.graphical)
                            .transition(.scale)
                            .onChange(of: dueDate) { _, newValue in
                                toDo.dueDate = newValue.timeIntervalSince1970
                            }
                            .onAppear {
                                print(dueDate.addingTimeInterval(900).description)
                                proxy.scrollTo(bottomId)
                            }
                    }
                    if toDo.hasDueDate {
                        HStack {
                            BellImageView(showWaves: $toDo.addedToCalendar)
                            Toggle(toDo.addedToCalendar ? "Added to calendar" : "Add to calendar", isOn: $toDo.addedToCalendar)
                                .onChange(of: toDo.addedToCalendar) { _, newValue in
                                    focusedField = nil
                                    if newValue == true {
                                        // Add to reminders
                                    } else {
                                        // remove from reminders
                                    }
                                }
                                .onAppear {
                                    proxy.scrollTo(bottomId)
                                }
                                
                        }.id(bottomId)
                    }
                        
                    
                        
                }
            }// end of list
            .scrollDismissesKeyboard(.immediately)
            .listStyle(.plain)
        }// scrollviewreader
        
        .onChange(of: toDo) { _, _ in
            
            isModified = true
        }
        .onAppear {
            if !toDo.hasDueDate {
                self.dueDate = Date()
            }
            else {
                self.dueDate = Date(timeIntervalSince1970: toDo.dueDate ?? 0)
            }
        }
        .toolbar {
            BackButton {
                focusedField = nil
                
                if toDo != copyToDo {
                    showingConfirmationDialog = true
                } else {
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
        
        .confirmationDialog("", isPresented: $showingConfirmationDialog) {
            Button("Discard changes", role: .destructive, action: { dismiss() })
            Button("Save changes", action: { updateToDo() })
            Button("Cancel", role: .cancel, action: { })
        }
        
        FooterView(creationDate: $toDo.creationDate, completionDate: $toDo.completionDate)
        
        Button {
            updateToDo()
        } label: {
            ButtonLabel(text: "UPDATE", width: nil)
        }.padding()
        
    }
    
    func updateToDo() {
        
        focusedField = nil
        
        Task {
            if toDo.addedToCalendar && toDo.eventId == "" {
                let eventId = await dataManager.addToReminder(toDo)
                toDo.eventId = eventId
            } else if !toDo.addedToCalendar && toDo.eventId != "" {
                dataManager.removeFromReminder(toDo)
                toDo.eventId = ""
            } else if toDo.addedToCalendar && toDo.eventId != "" && toDo.dueDate != copyToDo.dueDate {
                dataManager.removeFromReminder(toDo)
                toDo.eventId = ""
                let eventId = await dataManager.addToReminder(toDo)
                toDo.eventId = eventId
            }
            
            dataManager.updateToDo(toDo)
            dismiss()
            
            //dataManager.showMessage(toDo.title, type: .update)
            
        }
    }
}

#Preview {
    ToDoDetailView2(ToDo(title: "", description: "", creationDate: 0))
}


