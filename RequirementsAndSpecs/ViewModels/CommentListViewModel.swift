//
//  CommentListViewModel.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//
import Foundation

class CommentListViewModel: ObservableObject
{
    @Published var comments: [Comment] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    init()
    {
        retrieveComments()
    }
    
    @MainActor
    func retrieveComments()
    {
        do
        {
            isLoading = true
            
            defer
            {
                isLoading = false
            }
            
            requirements = DatabaseManager.
        }
        catch
        {
            showAlert = true
            errorMessage = "Error occurred while retrieving comments from the database."
        }
    }
}
