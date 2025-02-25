//
//  SettingsToolbarButton.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 05/01/2025.
//
import SwiftUI

struct SettingsToolbarButton: ToolbarContent {
    var body: some ToolbarContent {
        ToolbarItem (placement: .topBarTrailing) {
            NavigationLink {
                SettingsView()
            } label: {
                Image(systemName: "gearshape")
            }
        }
    }
}
