//
//  Role.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
import Foundation
import CoreData

//  Presentation layer struct that has computed fields that
//  return the values from the RoleEntity database class
struct Role: Identifiable
{
    let roleEntity: RoleEntity
    
    var id: NSManagedObjectID
    {
        return roleEntity.objectID
    }
    
    var roleId: String
    {
        return roleEntity.wrappedRoleId
    }
    
    var roleName: String
    {
        return roleEntity.wrappedRoleName
    }
    
    var dateCreated: String
    {
        return roleEntity.dateCreated?.asShortDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var lastUpdated: String
    {
        return roleEntity.lastUpdated?.asLongDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var users: [User]
    {
        return roleEntity.userArray.map(User.init)
    }
    
    var projects: [Project]
    {
        return roleEntity.projectArray.map(Project.init)
    }
}
