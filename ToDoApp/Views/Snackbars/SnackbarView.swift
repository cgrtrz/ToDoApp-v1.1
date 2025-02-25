//
//  SnackbarView.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 02/01/2025.
//

import SwiftUI

struct SnackbarView: View {
    
    @Binding var isShowing: Bool
    var message: LocalizedStringKey
    
    var body: some View {
        if isShowing {
            VStack {
                Spacer()
                HStack {
                    Text(message)
                        //.foregroundStyle(.white)
                        .padding()
                }
                
                .frame(maxWidth: .infinity, minHeight: 64)
                .background {
                    Color(UIColor.systemGray6)
                        .opacity(1)
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 1, x: 1, y: 1)
                .padding(.horizontal, 24)
                .padding(.bottom, 112)
                .animation(.easeInOut)
            }
            .transition(.opacity)
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isShowing = false
                }
            }
        }
    }
}

#Preview {
    SnackbarView(isShowing: .constant(true), message: "Message...!")
}

extension View {
    func snackbar(isShowing: Binding<Bool>, message: LocalizedStringKey) -> some View{
        return self.modifier(SnackbarModifier(isShowing: isShowing, message: message))
        
    }
}

struct SnackbarModifier: ViewModifier {
    
    @Binding var isShowing: Bool
    var message: LocalizedStringKey
    
    func body(content: Content) -> some View {
        ZStack {
            content
            SnackbarView(isShowing: $isShowing, message: message)
        }
    }
}
