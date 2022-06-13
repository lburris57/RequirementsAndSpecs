//
//  TestEntity+CoreDataProperties.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
//
import CoreData
import Foundation

extension TestEntity
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestEntity>
    {
        return NSFetchRequest<TestEntity>(entityName: "TestEntity")
    }

    @NSManaged public var testId: String?
    @NSManaged public var title: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var testType: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var requirements: NSSet?
    
    public var wrappedTestId: String
    {
        testId ?? Constants.EMPTY_STRING
    }

    public var wrappedTitle: String
    {
        title ?? Constants.EMPTY_STRING
    }

    public var wrappedDescriptionText: String
    {
        descriptionText ?? Constants.EMPTY_STRING
    }

    public var wrappedTestType: String
    {
        testType ?? Constants.EMPTY_STRING
    }
    
    public var requirementArray: [RequirementEntity]
    {
        let set = requirements as? Set<RequirementEntity> ?? []

        return set.sorted
        {
            $0.wrappedRequirementId < $1.wrappedRequirementId
        }
    }
}

// MARK: Generated accessors for requirements

extension TestEntity
{
    @objc(addRequirementsObject:)
    @NSManaged public func addToRequirements(_ value: RequirementEntity)

    @objc(removeRequirementsObject:)
    @NSManaged public func removeFromRequirements(_ value: RequirementEntity)

    @objc(addRequirements:)
    @NSManaged public func addToRequirements(_ values: NSSet)

    @objc(removeRequirements:)
    @NSManaged public func removeFromRequirements(_ values: NSSet)
}

extension TestEntity: Identifiable
{
}
