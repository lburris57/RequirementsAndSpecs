//
//  RequirementListViewModel.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import Foundation

class RequirementListViewModel: ObservableObject
{
    @Published var requirements: [Requirement] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    init()
    {
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
    
    func saveRequirement(_ requirement: Requirement)
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
    
    func deleteRequirement(_ requirement: Requirement)
    {
        isLoading = true
        
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
            errorMessage = "Error occurred while deleting requirement \(requirement.requirementId) from the database."
        }
    }
}
