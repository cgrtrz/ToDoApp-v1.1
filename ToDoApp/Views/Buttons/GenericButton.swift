//
//  GenericButton.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 01/01/2025.
//

import SwiftUI

struct GenericButton: View {
   
    var text: String
    var action: () -> Void
    
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 300, height: 50)
                    .foregroundStyle(Constants.gradient).shadow(radius: 6)
                Text(text)
                    .font(.title)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    GenericButton(text: "Test") {
        //
    }
    .environmentObject(SettingsManager())
}
