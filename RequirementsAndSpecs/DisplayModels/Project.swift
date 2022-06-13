//
//  Project.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
import Foundation
import CoreData

//  Presentation layer struct that has computed fields that
//  return the values from the ProjectEntity database class
struct Project: Identifiable
{
    let projectEntity: ProjectEntity
    
    var id: NSManagedObjectID
    {
        return projectEntity.objectID
    }
    
    var projectId: String
    {
        return projectEntity.wrappedProjectId
    }
    
    var title: String
    {
        return projectEntity.wrappedTitle
    }
    
    var descriptionText: String
    {
        return projectEntity.wrappedDescriptionText
    }
    
    var createdBy: String
    {
        return projectEntity.wrappedCreatedBy
    }
    
    var dateCreated: String
    {
        return projectEntity.dateCreated?.asShortDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var lastUpdated: String
    {
        return projectEntity.lastUpdated?.asLongDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var users: [User]
    {
        return projectEntity.userArray.map(User.init)
    }
    
    var requirements: [Requirement]
    {
        return projectEntity.requirementArray.map(Requirement.init)
    }
    
    var groups: [UserGroup]
    {
        return projectEntity.groupArray.map(UserGroup.init)
    }
    
    var roles: [Role]
    {
        return projectEntity.roleArray.map(Role.init)
    }
}
