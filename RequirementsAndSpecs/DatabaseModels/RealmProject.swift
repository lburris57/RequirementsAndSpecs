//
//  RealmProject.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/2/22.
//

import Foundation
import RealmSwift

class RealmProject : Object
{
    @Persisted(primaryKey: true) var id : String = UUID().uuidString
    @Persisted var projectId : String = Constants.EMPTY_STRING
    @Persisted var title : String = Constants.EMPTY_STRING
    @Persisted var descriptionText : String = Constants.EMPTY_STRING
    @Persisted var createdBy : String = Constants.EMPTY_STRING
    @Persisted var dateCreated: String = Date().asFormattedString()
    @Persisted var lastUpdated: String = Date().asFormattedString()
    
    @Persisted var userList = List<RealmUser>()
    @Persisted var requirementList = List<RealmRequirement>()
    @Persisted var groupList = List<RealmUserGroup>()
    @Persisted var roleList = List<RealmRole>()
    
    //  Computed field to convert List<> into array
    var users: [RealmUser]
    {
        return DatabaseManager.convertToArrayFromList(results: userList)
    }
    
    var requirements: [RealmRequirement]
    {
        return DatabaseManager.convertToArrayFromList(results: requirementList)
    }
    
    //  Computed fields to convert List<> into array
    var groups: [RealmUserGroup]
    {
        return DatabaseManager.convertToArrayFromList(results: groupList)
    }
    
    var roles: [RealmRole]
    {
        return DatabaseManager.convertToArrayFromList(results: roleList)
    }
}
