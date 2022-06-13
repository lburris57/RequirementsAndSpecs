//
//  Defect.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
import Foundation
import CoreData

//  Presentation layer struct that has computed fields that
//  return the values from the DefectEntity database class
struct Defect: Identifiable
{
    let defectEntity: DefectEntity
    
    var id: NSManagedObjectID
    {
        return defectEntity.objectID
    }
    
    var defectId: String
    {
        return defectEntity.wrappedDefectId
    }
    
    var title: String
    {
        return defectEntity.wrappedTitle
    }
    
    var severity: String
    {
        return defectEntity.wrappedSeverity
    }
    
    var priority: String
    {
        return defectEntity.wrappedPriority
    }
    
    var assignedToUserId: String
    {
        return assignedUser.userId
    }
    
    var isCompleted: Bool
    {
        return defectEntity.isCompleted
    }
    
    var dateCreated: String
    {
        return defectEntity.dateCreated?.asShortDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var lastUpdated: String
    {
        return defectEntity.lastUpdated?.asLongDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var assignedUser: User
    {
        return User(userEntity: defectEntity.wrappedUser)
    }
    
    var requirements: [Requirement]
    {
        return defectEntity.requirementArray.map(Requirement.init)
    }
}
