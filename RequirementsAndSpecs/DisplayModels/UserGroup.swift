//
//  UserGroup.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
import Foundation
import CoreData

//  Presentation layer struct that has computed fields that
//  return the values from the UserGroupEntity database class
struct UserGroup: Identifiable
{
    let userGroupEntity: UserGroupEntity
    
    var id: NSManagedObjectID
    {
        return userGroupEntity.objectID
    }
    
    var groupId: String
    {
        return userGroupEntity.wrappedGroupId
    }
    
    var groupName: String
    {
        return userGroupEntity.wrappedGroupName
    }
    
    var dateCreated: String
    {
        return userGroupEntity.dateCreated?.asShortDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var lastUpdated: String
    {
        return userGroupEntity.lastUpdated?.asLongDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var users: [User]
    {
        return userGroupEntity.userArray.map(User.init)
    }
    
    var projects: [Project]
    {
        return userGroupEntity.projectArray.map(Project.init)
    }
}
