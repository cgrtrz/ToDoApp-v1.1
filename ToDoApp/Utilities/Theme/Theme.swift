//
//  Theme.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 24/12/2024.
//

import Foundation
import SwiftUI

protocol Theme: Codable {
    var tintColor: Color { get }
}

enum Themes: CaseIterable, Codable, Equatable {
  
    case purple, mint, bw, blue, orange
    
    var colors: Theme {
        switch self {
        case .purple: PurpleTheme()
        case .mint: MintTheme()
        case .bw: BWTheme()
        case .blue: BlueTheme()
        case .orange: OrangeTheme()
        }
    }
}

struct PurpleTheme: Theme {
    var tintColor: Color { .purple }
}

struct MintTheme: Theme {
    var tintColor: Color { .mint }
}

struct BWTheme: Theme {
    var tintColor: Color { Color(.label) }
}

struct BlueTheme: Theme {
    var tintColor: Color { .blue }
}

struct OrangeTheme: Theme {
    var tintColor: Color { .orange }
}

struct test: View {
    var body: some View {
        Themes.purple.colors.tintColor
        
    }
}
#Preview {
    test()
}
