//
//  EventManagerError.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 15/12/2024.
//

import Foundation

enum EventManagerError: Error {
    // TODO: Set meaningful error descriptions.
    // FIXME: Add all error cases.
    case invalidDueDate
    
    var description: String {
        switch self {
        case .invalidDueDate:
            return "Invalid due date"
        }
    }
}
