//
//  User.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
import Foundation
import CoreData

//  Presentation layer struct that has computed fields that
//  return the values from the UserEntity database class
struct User: Identifiable
{
    let userEntity: UserEntity
    
    var id: NSManagedObjectID
    {
        return userEntity.objectID
    }
    
    var userId: String
    {
        return userEntity.wrappedUserId
    }
    
    var userName: String
    {
        return userEntity.wrappedUserName
    }
    
    var password: String
    {
        return userEntity.wrappedPassword
    }
    
    var dateCreated: String
    {
        return userEntity.dateCreated?.asShortDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var lastUpdated: String
    {
        return userEntity.lastUpdated?.asLongDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var roles: [Role]
    {
        return userEntity.roleArray.map(Role.init)
    }
    
    var defects: [Defect]
    {
        return userEntity.defectArray.map(Defect.init)
    }
    
    var requirements: [Requirement]
    {
        return userEntity.requirementArray.map(Requirement.init)
    }
    
    var groups: [UserGroup]
    {
        return userEntity.groupArray.map(UserGroup.init)
    }
    
    var projects: [Project]
    {
        return userEntity.projectArray.map(Project.init)
    }
    
    
}
