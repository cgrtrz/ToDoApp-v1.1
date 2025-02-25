//
//  ButtonLabel.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 01/01/2025.
//

import SwiftUI

struct ButtonLabel: View {
    
    var imageName: String = ""
    var text: LocalizedStringKey = ""
    var width: CGFloat? = 200
    var height: CGFloat = 36
    var alignment: TextAlignment = .center
    var imagePlacement: ImagePlacement = .leading
    
    enum ImagePlacement {
        case leading, trailing
    }
    
    enum TextAlignment {
        case leading, center, trailing
    }
    
    var body: some View {
        ZStack {
            Capsule(style: .circular)
                .foregroundStyle(.blue)
                .shadow(color: Color(.darkGray).opacity(0.5),radius: 3, x: 3, y: 3)
                .shadow(color: Color(.systemGray3).opacity(0.5),radius: 3, x: -3, y: -3)
                HStack {
                    if alignment == .trailing {
                        Spacer()
                    }
                    if imagePlacement == .leading {
                        Image(systemName: imageName)
                            //.font(.title)
                        Text(text)
                            //.font(.title2)
                            .fontWeight(.bold)
                    } else if imagePlacement == .trailing {
                        Text(text)
                            //.font(.title2)
                            .fontWeight(.bold)
                        Image(systemName: imageName)
                            .font(.title)
                    }
                    if alignment == .leading {
                        Spacer()
                    }
                }
                .foregroundStyle(.white)
                .padding()
            
        }
        .frame(width: width, height: height)
        .padding(.horizontal, 8)
    }
}

#Preview {
    ButtonLabel(imageName: "gearshape.fill", text: "Test", width: nil, alignment: .center, imagePlacement: .trailing)
}
