//
//  MessageView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 01/01/2025.
//
import SwiftUI

struct MessageView: View {
    
    var message: String = ""
    
    var body: some View {
        withAnimation(.interactiveSpring()) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color(.systemGray6).opacity(0.3))
                    .shadow(radius: 5)
                Text(message)
            }.frame(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height * 0.085)
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 200)
        }
        
    }
}

