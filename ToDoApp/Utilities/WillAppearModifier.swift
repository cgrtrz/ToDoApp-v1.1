//
//  WillAppearModifier.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 04/01/2025.
//
import SwiftUI

extension View {
    func onWillAppear(_ perform: @escaping () -> Void) -> some View {
        modifier(WillAppearModifier(callback: perform))
    }
}

struct WillAppearModifier: ViewModifier {
    let callback: () -> Void

    func body(content: Content) -> some View {
        content.background(UIViewLifeCycleHandler(onWillAppear: callback))
    }
}
