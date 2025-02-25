//
//  ToDoAppWidgetExtensionLiveActivity.swift
//  ToDoAppWidgetExtension
//
//  Created by Cagri Terzi on 25/02/2025.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ToDoAppWidgetExtensionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ToDoAppWidgetExtensionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ToDoAppWidgetExtensionAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ToDoAppWidgetExtensionAttributes {
    fileprivate static var preview: ToDoAppWidgetExtensionAttributes {
        ToDoAppWidgetExtensionAttributes(name: "World")
    }
}

extension ToDoAppWidgetExtensionAttributes.ContentState {
    fileprivate static var smiley: ToDoAppWidgetExtensionAttributes.ContentState {
        ToDoAppWidgetExtensionAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ToDoAppWidgetExtensionAttributes.ContentState {
         ToDoAppWidgetExtensionAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ToDoAppWidgetExtensionAttributes.preview) {
   ToDoAppWidgetExtensionLiveActivity()
} contentStates: {
    ToDoAppWidgetExtensionAttributes.ContentState.smiley
    ToDoAppWidgetExtensionAttributes.ContentState.starEyes
}
