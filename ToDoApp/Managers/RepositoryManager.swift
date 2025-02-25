//
//  RepositoryFactory.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 12/12/2024.
//

import Foundation

final class RepositoryManager {
    
    static let shared = RepositoryManager()
    
    //Set repositories to inject into the app.
    private let toDoRepositoryType: ToDoRepositoryType = .coreData
    //private let authenticationRepositoryType: AuthenticationRepositoryType = .mocked
    private let settingsRepositoryType: SettingsRepositoryType = .userDefaults
    
    func getToDoRepository() -> ToDoRepository {
        switch toDoRepositoryType {
        case .inMemory:
            return InMemoryToDoRepository()
        case .mockedNetwork:
            return MockedNetworkToDoRepository()
        case .coreData:
            return CoreDataToDoRepository()
        }
    }
    
//    func getAuthenticationRepository() -> AuthenticationRepository {
//        switch authenticationRepositoryType {
//        case .mocked:
//            return MockedAuthenticationRepository()
//        case .firebase:
//            return FirebaseAuthenticationRepository()
//        case .apple:
//            return AppleAuthenticationRepository()
//        }
//    }
    
    func getSettingsRepository() -> SettingsRepository {
        switch settingsRepositoryType {
        case .userDefaults:
            return UserDefaultsSettingsRepository()
        }
    }
}
