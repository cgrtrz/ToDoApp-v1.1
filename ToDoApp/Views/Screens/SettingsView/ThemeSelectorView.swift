//
//  ThemeSelectorView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 27/12/2024.
//

import SwiftUI

struct ThemeSelectorView: View {
    var body: some View {
        VStack (alignment: .center){
            Spacer()

        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(width: 200, height: 400)
            Button {
                
            } label: {
                Text("Select Theme")
            }
            .padding()
    }
    }
}

#Preview {
    ThemeSelectorView()
}
