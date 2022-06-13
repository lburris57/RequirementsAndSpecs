//
//  AddCommentViewModel.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import Foundation

class AddCommentViewModel: ObservableObject
{
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    func saveComment(_ comment: RealmComment)
    {
        do
        {
            try DatabaseManager.saveComment(comment)
        }
        catch
        {
            showAlert = true
            errorMessage = "Error occurred while saving comment to the database."
        }
    }
}
