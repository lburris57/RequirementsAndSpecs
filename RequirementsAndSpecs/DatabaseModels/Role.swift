//
//  Role.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/9/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class Role : Object
{
    @Persisted(primaryKey: true) var id : String = UUID().uuidString
    @Persisted var roleId : String = Constants.EMPTY_STRING
    @Persisted var roleName : String = Constants.EMPTY_STRING
    @Persisted var dateCreated: String = Date().asFormattedString()
    @Persisted var lastUpdated: String = Date().asFormattedString()
    
    @Persisted var userList = List<User>()
    
    //  Computed field to convert List<> into array
    var users: [User]
    {
        return DatabaseManager.convertToArrayFromList(results: userList)
    }
}
