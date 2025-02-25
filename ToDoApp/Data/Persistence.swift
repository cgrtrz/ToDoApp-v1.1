//
//  Persistence.swift
//  ToDoApp
//
//  Created by Cagri Terzi on 12/12/2024.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentCloudKitContainer

    init() {
        container = NSPersistentCloudKitContainer(name: "ToDoApp")
        
        // Persistent store descriptions oluştur
        let cloudStoreDescription = NSPersistentStoreDescription(url: URL(fileURLWithPath: "\(NSPersistentContainer.defaultDirectoryURL().path)/CloudStore.sqlite"))
        cloudStoreDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: "iCloud.com.tequilatech.TequilaToDoApp")
        
        let localStoreDescription = NSPersistentStoreDescription(url: URL(fileURLWithPath: "\(NSPersistentContainer.defaultDirectoryURL().path)/LocalStore.sqlite"))
        localStoreDescription.cloudKitContainerOptions = nil // Lokal store CloudKit'e bağlanmayacak
        
        // Persistent store descriptions ekle
        container.persistentStoreDescriptions = [cloudStoreDescription, localStoreDescription]
        
        // Persistent store'ları yükle
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                fatalError("Persistent store yüklenirken hata oluştu: \(error.localizedDescription)")
            }
            
            if let options = storeDescription.cloudKitContainerOptions {
                print("CloudKit Store Yüklendi: \(options.containerIdentifier)")
            } else {
                print("Local Store Yüklendi: \(storeDescription.url?.absoluteString ?? "Unknown URL")")
            }
        }
        
        // Arka plan değişikliklerini ana bağlama yansıt
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}
