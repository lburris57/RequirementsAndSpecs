//
//  Requirement.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
import Foundation
import CoreData

//  Presentation layer struct that has computed fields that
//  return the values from the RequirementEntity database class
struct Requirement: Identifiable
{
    let requirementEntity: RequirementEntity
    
    var id: NSManagedObjectID
    {
        return requirementEntity.objectID
    }
    
    var requirementId: String
    {
        return requirementEntity.wrappedRequirementId
    }
    
    var title: String
    {
        return requirementEntity.wrappedTitle
    }
    
    var descriptionText: String
    {
        return requirementEntity.wrappedDescriptionText
    }
    
    var group: String
    {
        return requirementEntity.wrappedGroup
    }
    
    var status: String
    {
        return requirementEntity.wrappedStatus
    }
    
    var category: String
    {
        return requirementEntity.wrappedCategory
    }
    
    var priority: String
    {
        return requirementEntity.wrappedPriority
    }
    
    var complexity: String
    {
        return requirementEntity.wrappedComplexity
    }
    
    var functionalArea: String
    {
        return requirementEntity.wrappedFunctionalArea
    }
    
    var isCompleted: Bool
    {
        return requirementEntity.isCompleted
    }
    
    var isValidated: Bool
    {
        return requirementEntity.isValidated
    }
    
    var createdBy: String
    {
        return requirementEntity.wrappedCreatedBy
    }
    
    var relatedDocuments: String
    {
        return requirementEntity.wrappedRelatedDocuments
    }
    
    var unitTestId: String
    {
        return requirementEntity.wrappedUnitTestId
    }
    
    var behavioralTestId: String
    {
        return requirementEntity.wrappedBehavioralTestId
    }
    
    var dateCreated: String
    {
        return requirementEntity.dateCreated?.asShortDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var lastUpdated: String
    {
        return requirementEntity.lastUpdated?.asLongDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var comments: [Comment]
    {
        return requirementEntity.commentArray.map(Comment.init)
    }
    
    var user: User
    {
        return User(userEntity: requirementEntity.wrappedUser)
    }
    
    var project: Project
    {
        return Project(projectEntity: requirementEntity.wrappedProject)
    }
    
    var test: Test
    {
        return Test(testEntity: requirementEntity.wrappedTest)
    }
    
    var defect: Defect
    {
        return Defect(defectEntity: requirementEntity.wrappedDefect)
    }
}
