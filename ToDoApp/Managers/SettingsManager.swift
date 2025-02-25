//
//  SettingsManager.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 24/12/2024.
//

import Foundation


final class SettingsManager: ObservableObject {
    
    @Published var settings: Settings
    
    private let repository: SettingsRepository = RepositoryManager.shared.getSettingsRepository()
    
    init() {
        self.settings = repository.load()
    }
    
    
    func loadSettings() {
        settings = repository.load()
    }
    
    func saveSettings(_ settings: Settings) {
        repository.save(settings: settings)
    }
}
