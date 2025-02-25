//
//  SelectedRepository.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 11/12/2024.
//

import Foundation

/**
 Types of data source.

 Defines data source from which ViewModel processes data.
 
 - Author: Cagri Terzi
 - Important: Add new case when new data source added.
 */
enum ToDoRepositoryType {
    case inMemory
    case mockedNetwork
    case coreData
}
