//
//  OnboardingView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 09/02/2025.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack (spacing: 12){
            Image("launch")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            Text("Welcome to ToDo App!")
        }
        
    }
}

#Preview {
    OnboardingView()
}
