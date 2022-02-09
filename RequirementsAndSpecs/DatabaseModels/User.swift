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
    @Persisted var dateCreated: String = Constants.EMPTY_STRING
    @Persisted var lastUpdated: String = Constants.EMPTY_STRING
    
    @Persisted var groups = List<UserGroup>()
    @Persisted var roles = List<Role>()
    @Persisted var defects = List<Defect>()
}
