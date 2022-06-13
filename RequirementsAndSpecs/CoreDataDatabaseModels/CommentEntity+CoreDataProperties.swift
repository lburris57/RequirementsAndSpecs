//
//  CommentEntity+CoreDataProperties.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
//
import CoreData
import Foundation

extension CommentEntity
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CommentEntity>
    {
        return NSFetchRequest<CommentEntity>(entityName: "CommentEntity")
    }

    @NSManaged public var commentId: String?
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var commentText: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var requirement: RequirementEntity?
    
    public var wrappedCommentId: String
    {
        commentId ?? Constants.EMPTY_STRING
    }

    public var wrappedTitle: String
    {
        title ?? Constants.EMPTY_STRING
    }

    public var wrappedAuthor: String
    {
        author ?? Constants.EMPTY_STRING
    }

    public var wrappedCommentText: String
    {
        commentText ?? Constants.EMPTY_STRING
    }

    public var wrappedRequirement: RequirementEntity
    {
        requirement ?? RequirementEntity()
    }
}

extension CommentEntity: Identifiable
{
}
