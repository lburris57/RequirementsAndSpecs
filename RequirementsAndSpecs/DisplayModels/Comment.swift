//
//  Comment.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
import Foundation
import CoreData

//  Presentation layer struct that has computed fields that
//  return the values from the CommentEntity database class
struct Comment: Identifiable
{
    let commentEntity: CommentEntity
    
    var id: NSManagedObjectID
    {
        return commentEntity.objectID
    }
    
    var commentId: String
    {
        return commentEntity.wrappedCommentId
    }
    
    var title: String
    {
        return commentEntity.wrappedTitle
    }
    
    var author: String
    {
        return commentEntity.wrappedAuthor
    }
    
    var commentText: String
    {
        return commentEntity.wrappedCommentText
    }
    
    var dateCreated: String
    {
        return commentEntity.dateCreated?.asShortDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var lastUpdated: String
    {
        return commentEntity.lastUpdated?.asLongDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var parentRequirement: Requirement
    {
        return Requirement(requirementEntity: commentEntity.wrappedRequirement)
    }
}
