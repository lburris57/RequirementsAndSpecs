//
//  Comment.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class Comment : Object
{
    @Persisted(primaryKey: true) var id : String = UUID().uuidString
    @Persisted var requirementId: String = Constants.EMPTY_STRING
    @Persisted var commentId: String = Constants.EMPTY_STRING
    @Persisted var title: String = Constants.EMPTY_STRING
    @Persisted var author : String = Constants.EMPTY_STRING
    @Persisted var commentText : String = Constants.EMPTY_STRING
    @Persisted var dateCreated: String = Date().asFormattedString()
    @Persisted var lastUpdated: String = Date().asFormattedString()
    
    @Persisted(originProperty: "commentList") var parentRequirement : LinkingObjects<Requirement>
}
