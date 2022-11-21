//
//  RequirementListViewModel.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import Foundation
import CoreData

class RequirementListViewModel: ObservableObject
{
    @Published var requirements: [RealmRequirement] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    private (set) var viewContext: NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext)
    {
        self.viewContext = viewContext
        
        retrieveRequirementList()
    }
    
    func retrieveRequirementList()
    {
        do
        {
            isLoading = true
            
            defer
            {
                isLoading = false
            }
            
            requirements = try DatabaseManager.retrieveAllRequirements()
        }
        catch
        {
            showAlert = true
            errorMessage = "Error occurred while retrieving requirements from the database."
        }
    }
    
    func saveRequirement(_ requirement: RealmRequirement)
    {
        isLoading = true
        
        defer
        {
            isLoading = false
        }
        
        do
        {
            try DatabaseManager.saveRequirement(requirement)
        }
        catch
        {
            showAlert = true
            errorMessage = "Error occurred while saving requirement \(requirement.requirementId) to the database."
        }
    }
    
    func deleteRequirement(_ requirement: RealmRequirement)
    {
        isLoading = true
        
        let requirementId = requirement.requirementId
        
        defer
        {
            isLoading = false
        }
        
        do
        {
            try DatabaseManager.deleteRequirement(requirement)
        }
        catch
        {
            showAlert = true
            errorMessage = "Error occurred while deleting requirement \(requirementId) from the database."
        }
    }
}
