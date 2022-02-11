//
//  User.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/9/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class User : Object
{
    @Persisted(primaryKey: true) var id : String = UUID().uuidString
    @Persisted var userId : String = Constants.EMPTY_STRING
    @Persisted var userName : String = Constants.EMPTY_STRING
    @Persisted var password : String = Constants.EMPTY_STRING
    @Persisted var dateCreated: String = Date().asFormattedString()
    @Persisted var lastUpdated: String = Date().asFormattedString()
    
    @Persisted var groupList = List<UserGroup>()
    @Persisted var roleList = List<Role>()
    @Persisted var defectList = List<Defect>()
    
    //  Computed fields to convert List<> into array
    var groups: [UserGroup]
    {
        return DatabaseManager.convertToArrayFromList(results: groupList)
    }
    
    var roles: [Role]
    {
        return DatabaseManager.convertToArrayFromList(results: roleList)
    }
    
    var defects: [Defect]
    {
        return DatabaseManager.convertToArrayFromList(results: defectList)
    }
}
