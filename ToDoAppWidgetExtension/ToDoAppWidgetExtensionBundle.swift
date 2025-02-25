//
//  ToDoAppWidgetExtensionBundle.swift
//  ToDoAppWidgetExtension
//
//  Created by Cagri Terzi on 25/02/2025.
//

import WidgetKit
import SwiftUI

@main
struct ToDoAppWidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        ToDoAppWidgetExtension()
        ToDoAppWidgetExtensionControl()
        ToDoAppWidgetExtensionLiveActivity()
    }
}
