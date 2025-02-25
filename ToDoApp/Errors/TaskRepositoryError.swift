//
//  TaskRepositoryError.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 11/12/2024.
//

import Foundation

enum TaskRepositoryError: String, Error {
    case taskNotFound = "Task not found..."
    case badRequest = "Bad request..."
}
