//
//  SettingsRepository.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 24/12/2024.
//

import Foundation

protocol SettingsRepository {
    func createSettings()
    func save(settings: Settings)
    func load() -> Settings
}

final class UserDefaultsSettingsRepository: SettingsRepository {
    
    private let defaultSettings: Settings = Settings(selectedTheme: .purple)
    
    func createSettings() {
        
        if let data = try? JSONEncoder().encode(defaultSettings) {
            UserDefaults.standard.set(data, forKey: "settings")
        }
    }
    
    func save(settings: Settings) {
        if let data = try? JSONEncoder().encode(settings) {
            UserDefaults.standard.set(data, forKey: "settings")
        }
    }
    
    func load() -> Settings {
        if let savedSettings = UserDefaults.standard.data(forKey: "settings") {
            if let settings = try? JSONDecoder().decode(Settings.self, from: savedSettings) {
                return settings
            }
        }
            return defaultSettings
    }
}
