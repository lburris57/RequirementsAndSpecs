//
//  RequirementsAndSpecsApp.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import SwiftUI

@main
struct RequirementsAndSpecsApp: App
{
    var body: some Scene
    {
        WindowGroup
        {
            let viewContext = CoreDataManager.shared.persistentContainer.viewContext
            
            LoginView()
                .environment(\.managedObjectContext, viewContext)
            .onAppear
            {
                UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
            }
        }
    }
}
