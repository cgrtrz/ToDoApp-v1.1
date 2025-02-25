//
//  ToggleStyle+CompletedTaskToggleStyle.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 06/12/2024.
//

import Foundation
import SwiftUI


struct ToDoToogleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "checkmark.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(configuration.isOn ? Color.green : Color.gray)
                .frame(width: 24, height: 24)
                .onTapGesture {
                    //withAnimation {
                        configuration.isOn.toggle()
                    //}
                }
        }
    }
}

struct CustomDatePicker: DatePickerStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            VStack {
                Text("Custom Style")
                DatePicker("MY CUSTOM DESIGN", selection: configuration.$selection)
                    .foregroundStyle(Color.green)
            }
        }
    }
}
