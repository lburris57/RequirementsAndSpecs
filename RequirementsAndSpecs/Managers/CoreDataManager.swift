//
//  CoreDataManager.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 06/12/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import CoreData
import Foundation
import CloudKit

class CoreDataManager
{
    let persistentContainer: NSPersistentCloudKitContainer

    static let shared: CoreDataManager = CoreDataManager()
    
    private init()
    {
        persistentContainer = NSPersistentCloudKitContainer(name: "RequirementsAndSpecsDatabaseModel")
        persistentContainer.persistentStoreDescriptions.first!.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
        persistentContainer.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        persistentContainer.loadPersistentStores
        {
            _, error in

            if let error = error
            {
                Log.error("Unable to initialize Core Data: \(error.localizedDescription)")
            }
            else
            {
                Log.info("RequirementsAndSpecsDatabaseModel was successfully loaded!!")
            }
        }
    }
}



