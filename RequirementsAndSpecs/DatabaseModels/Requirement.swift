//
//  Requirement.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class Requirement : Object
{
    @Persisted(primaryKey: true) var id : String = UUID().uuidString
    @Persisted var requirementId : String = Constants.EMPTY_STRING
    @Persisted var title : String = Constants.EMPTY_STRING
    @Persisted var descriptionText : String = Constants.EMPTY_STRING
    @Persisted var group : String = Constants.EMPTY_STRING
    @Persisted var status : String = Constants.EMPTY_STRING
    @Persisted var category : String = Constants.EMPTY_STRING
    @Persisted var priority : String = Constants.EMPTY_STRING
    @Persisted var complexity : String = Constants.EMPTY_STRING
    @Persisted var functionalArea : String = Constants.EMPTY_STRING
    @Persisted var isCompleted : Bool = false
    @Persisted var createdBy : String = Constants.EMPTY_STRING
    @Persisted var relatedDocuments : String = Constants.EMPTY_STRING
    @Persisted var unitTestId : String = Constants.EMPTY_STRING
    @Persisted var behavioralTestId : String = Constants.EMPTY_STRING
    @Persisted var dateCreated: String = Date().asFormattedString()
    @Persisted var lastUpdated: String = Date().asFormattedString()
    
    @Persisted var commentList = List<Comment>()
    
    //  Computed field to convert List<> into array
    var comments: [Comment]
    {
        return DatabaseManager.convertToArrayFromList(results: commentList)
    }
}
