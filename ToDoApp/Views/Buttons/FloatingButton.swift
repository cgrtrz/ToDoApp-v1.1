//
//  FloatingActionButton.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 02/01/2025.
//

import SwiftUI

struct FloatingButton: View {
    
    var color: Color = Color(.systemBlue)
    var iconColor: Color = Color.white
    var icon: String = "plus"
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label : {
            ZStack{
                Circle()
                    .foregroundStyle(color)
                    .frame(width: 56, height: 56)
                    .shadow(radius: 10, x: 5, y: 5)
                Image(systemName: icon)
                    .bold()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(iconColor)
            }
        }
        
        
    }
    
}

#Preview {
    FloatingButton {
        //
    }
}


