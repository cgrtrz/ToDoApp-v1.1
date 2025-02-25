//
//  BackButton.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 05/01/2025.
//
import SwiftUI

struct BackButton: ToolbarContent {
    
    var action: () -> Void
    
    var body: some ToolbarContent {
        ToolbarItem (placement: .topBarLeading) {
            Button {
                action()
            } label: {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("ToDo App")
                }
            }
        }
    }
}
