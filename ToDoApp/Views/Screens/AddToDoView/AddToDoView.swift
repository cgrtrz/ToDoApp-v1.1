//
//  AddTaskView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 13/12/2024.
//

import SwiftUI




struct AddToDoView: View {
//
    enum Field: Hashable {
        case title
        case descr
    }
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var dataManager: DataManager
    @EnvironmentObject var settingsManager: SettingsManager
    @StateObject private var viewModel: AddToDoViewModel = AddToDoViewModel()
    
    //@ObservedObject var vm: ToDoListViewModel
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .center){
                List {
                    Section {
                        TextField("**Title**", text: $viewModel.title, axis: .vertical)
                            .font(.title)
                            .bold()
                            .focused($focusedField, equals: .title)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    focusedField = .title
                                }
                            }
                            .toolbar {
                                KeyboardToolbar {
                                    focusedField = nil 
                                }
                            }
                        
                        TextField("Description", text: $viewModel.description, axis: .vertical)
                            .lineLimit(4, reservesSpace: true)
                            .fontWeight(.semibold)
                            .focused($focusedField, equals: .descr)
                    }
                    
                    Section {
                        Toggle(isOn: $viewModel.showingDatePicker)
                        {
                            Text("Set Due Date")
                            
                        }
                        .onChange(of: viewModel.showingDatePicker) {
                            _, _ in
                            focusedField = nil
                        }
                        //.tint(Constants.gradient)
                        if viewModel.showingDatePicker {
                            DatePicker("Due Date", selection: $viewModel.dueDate, in: Date().addingTimeInterval(60 * 15)...)
                                .datePickerStyle(.graphical)
                                .id(Date().addingTimeInterval(60 * 15))
                        }
                        Toggle("Add to calendar", isOn: $viewModel.addToCalendar)
                            .disabled(!viewModel.showingDatePicker)
                            //.tint(Constants.gradient)
                            .onChange(of: viewModel.addToCalendar) { _, _ in
                                focusedField = nil
                            }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Add new")
                .navigationBarTitleDisplayMode(.inline)
                
                Spacer()
                Button {
                    focusedField = nil
                    viewModel.addNew()
                    dataManager.addToDo(viewModel.newToDo)
                    dismiss()
                } label : {
                    ButtonLabel(text: "ADD", width: nil, height: 36)
                }
                .disabled(viewModel.title.isEmpty)
                .padding(16)
            }
        }
    }
}

#Preview {
    AddToDoView()
        .environmentObject(SettingsManager())
}

struct KeyboardToolbar: ToolbarContent {
    
    var action: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .keyboard) {
            HStack {
                Spacer()
                Button("Close") {
                    action()
                }
            }
        }
        
    }
}
