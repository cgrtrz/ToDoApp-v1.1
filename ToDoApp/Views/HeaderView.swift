//
//  HeaderView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 01/01/2025.
//


import SwiftUI

struct HeaderView:View {
    var body: some View {
        HStack{
            Text("To Do App")
                .font(.largeTitle)
                .bold()
                //.foregroundStyle(Constants.gradient)
            Spacer()
        }.padding(.horizontal, 36)
    }
}
