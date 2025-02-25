//
//  SettingsView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 16/12/2024.
//

import SwiftUI

struct SettingsView: View {
    
    //@EnvironmentObject var authManager: AuthenticationManager
    @EnvironmentObject var settingsManager: SettingsManager
    
    @State private var isOn: Bool = false
    @State var isThemePopoverPresented: Bool = false
    @State var themeIsLoading: Bool = false {
        didSet {
            if themeIsLoading {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.themeIsLoading = false
                }
            }
        }
    }
    //@State private var selectedToDoListType: ToDoListType = .all
    //@State var settings: Settings
    
    var body: some View {
        NavigationStack {
            
            List {
                
                Section ("Preferences"){
                  
                    HStack {
                        Text("Default ToDo Type")
//                        Picker("aa", selection: $settingsManager.settings.selectedToDoListType) {
//                            ForEach(ToDoListType.allCases, id: \.self) { type in
//                                Text(type.name)
//                            }
//                        }
                    }
                    HStack {
                        //Text("Default ToDo Type")
                        Picker("Theme", selection: $settingsManager.settings.selectedTheme) {
                            ForEach(Themes.allCases, id: \.self) { theme in
                                Text(theme.colors.tintColor.description)
                                    .foregroundStyle(Color(theme.colors.tintColor))
                            }
                        }
                        .onChange(of: settingsManager.settings.selectedTheme) { _, _ in
                            themeIsLoading = true
                        }
                    }
                    Button("Change Theme") {
                        isThemePopoverPresented = true
                    }
//                    .popover(isPresented: $isThemePopoverPresented, attachmentAnchor: .point(.center), arrowEdge: .bottom) {
//                        Grid (horizontalSpacing: 5, verticalSpacing: 5) {
//                            GridRow {
//                                Image("Theme1")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width:100, height: 250)
//                                    
//                                Image("Theme2")
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width:100, height: 250)
//                            }
//                            
//                            .presentationCompactAdaptation(.none)
//                            .padding()
//                        }
//                    }
//
            }
                
                Section("Start Up") {
                    Toggle("Allow notifications", isOn: $isOn)
                    Toggle("Access to Reminders", isOn: $isOn)
                    Toggle("Access to Calendar", isOn: $isOn)
                }
                Section("Permissions") {
                    Toggle("Allow notifications", isOn: $isOn)
                    Toggle("Access to Reminders", isOn: $isOn)
                    Toggle("Access to Calendar", isOn: $isOn)
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $isThemePopoverPresented) {
                ThemeSelectorView()
                    .presentationDetents([.height(500)])
                    .presentationCornerRadius(16)
                    .presentationDragIndicator(.visible)
            }
            Button {
                //authManager.isUserAuthenticated = .signedOut
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 280, height: 50)
                        .foregroundStyle(settingsManager.settings.selectedTheme.colors.tintColor.gradient)
                    Text("Sign out")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .bold()
                        .padding(.horizontal, 8)
                        .foregroundStyle(.white)
                        
                }
            }
            GenericButton(text: "Sign out", action: {
                //
            })
            .toolbar {
                ToolbarItem (placement: .topBarTrailing) {
                    Button {
                        settingsManager.saveSettings(settingsManager.settings)
                    } label: {
                        Text("Save")
                        
                    }
                    
                    
                }
            }
            

            
        }
        .overlay {
            if themeIsLoading {
                Color(.label).opacity(0.25)
                    .blur(radius: 10)
                    .ignoresSafeArea()
                ZStack (alignment: .center) {
                    
                    
                            RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color.black.opacity(0.5))
                                .frame(width: 250, height: 150)
                                .shadow(radius: 20)
                        VStack {
                            ProgressView()
                                .tint(.white)
                                .padding()
                            Text("Theme is loading...")
                                .foregroundStyle(Color.white)
                        }
                        
                        
                    
                }
            }
        }
    }
}


#Preview {
    SettingsView()
        .environmentObject(SettingsManager())
}
