//
//  Test.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
import Foundation
import CoreData

//  Presentation layer struct that has computed fields that
//  return the values from the TestEntity database class
struct Test: Identifiable
{
    let testEntity: TestEntity
    
    var id: NSManagedObjectID
    {
        return testEntity.objectID
    }
    
    var testId: String
    {
        return testEntity.wrappedTestId
    }
    
    var title: String
    {
        return testEntity.wrappedTitle
    }
    
    var descriptionText: String
    {
        return testEntity.wrappedDescriptionText
    }
    
    var testType: String
    {
        return testEntity.wrappedTestType
    }
    
    var dateCreated: String
    {
        return testEntity.dateCreated?.asShortDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var lastUpdated: String
    {
        return testEntity.lastUpdated?.asLongDateFormattedString() ?? Constants.EMPTY_STRING
    }
    
    var requirements: [Requirement]
    {
        return testEntity.requirementArray.map(Requirement.init)
    }
}
