//
//  Defect.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class Defect : Object
{
    @Persisted(primaryKey: true) var id : String = UUID().uuidString
    @Persisted var defectId : String = Constants.EMPTY_STRING
    @Persisted var title : String = Constants.EMPTY_STRING
    @Persisted var severity : String = Constants.EMPTY_STRING
    @Persisted var priority : String = Constants.EMPTY_STRING
    @Persisted var assignedToUserId : String = Constants.EMPTY_STRING
    @Persisted var isCompleted: Bool = false
    @Persisted var dateCreated: String = Constants.EMPTY_STRING
    @Persisted var lastUpdated: String = Constants.EMPTY_STRING
    
    @Persisted var requirements = List<Requirement>()
}
