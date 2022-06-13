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
    @Published var requirement: RealmRequirement = RealmRequirement()
    @Published var requirementId: String = Constants.EMPTY_STRING
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String = Constants.EMPTY_STRING
    
    func retrieveRequirement(_ requirementId: String)
    {
        do
        {
            isLoading = true

            defer
            {
                isLoading = false
            }

            if let retrievedRequirement = try DatabaseManager.retrieveRequirementById(requirementId)
            {
                requirement = retrievedRequirement
            }
        }
        catch
        {
            showAlert = true
            errorMessage = "Error occurred while retrieving requirement \(requirementId) from the database."
        }
    }
    
    func deleteComment(_ comment: RealmComment)
    {
        let commentTitle = comment.title
        
        do
        {
            isLoading = true

            defer
            {
                isLoading = false
            }
            
            try DatabaseManager.deleteComment(comment)
        }
        catch
        {
            showAlert = true
            errorMessage = "Error occurred while deleting comment \(commentTitle) from the database."
        }
    }
}
