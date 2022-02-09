//
//  Test.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/9/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class Test : Object
{
    @Persisted(primaryKey: true) var id : String = UUID().uuidString
    @Persisted var testId : String = Constants.EMPTY_STRING
    @Persisted var title : String = Constants.EMPTY_STRING
    @Persisted var descriptionText : String = Constants.EMPTY_STRING
    @Persisted var testType : String = Constants.EMPTY_STRING
    @Persisted var dateCreated: String = Constants.EMPTY_STRING
    @Persisted var lastUpdated: String = Constants.EMPTY_STRING
    
    @Persisted var requirements = List<Requirement>()
}
