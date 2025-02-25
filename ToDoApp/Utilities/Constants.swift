//
//  Constants.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 16/12/2024.
//

import SwiftUI

struct Constants {
    
    //static let shared = Constants()
    
    static let appIcon = "appicon"
    static let standardPadding: CGFloat = 12
    static let pad: EdgeInsets = .init(top: 12, leading: 12, bottom: 12, trailing: 12)
    static let gradient: LinearGradient = LinearGradient(colors: [.indigo, .cyan], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 1, y: 1))
    struct PopUp {
        //PopUp Screen -> MessageView
        static let width: CGFloat = UIScreen.main.bounds.width * 0.85
        static let height: CGFloat = UIScreen.main.bounds.height * 0.085
        static let xPosition: CGFloat = UIScreen.main.bounds.width / 2
        static let yPosition: CGFloat = UIScreen.main.bounds.height * 0.75
    }
    
    

}
