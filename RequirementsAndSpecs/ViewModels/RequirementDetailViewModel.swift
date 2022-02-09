//
//  RequirementDetailViewModel.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import Foundation

class RequirementDetailViewModel: ObservableObject
{
    @Published var requirement: Requirement = Requirement()
    @Published var requirementId: String = Constants.EMPTY_STRING
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String = Constants.EMPTY_STRING
    
    init()
    {
        retrieveRequirement(requirement.requirementId)
    }
    
    func retrieveRequirement(_ requirementId: String)
    {
        do
        {
            isLoading = true

            defer
            {
                isLoading = false
            }

            requirement = try DatabaseManager.retrieveRequirementById(requirementId) ?? Requirement()
        }
        catch
        {
            showAlert = true
            errorMessage = "Error occurred while retrieving requirement \(requirementId) from the database."
        }
    }
}
