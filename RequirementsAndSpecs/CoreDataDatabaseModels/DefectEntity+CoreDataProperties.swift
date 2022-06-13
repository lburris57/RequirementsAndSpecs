//
//  DefectEntity+CoreDataProperties.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
//
import CoreData
import Foundation

extension DefectEntity
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefectEntity>
    {
        return NSFetchRequest<DefectEntity>(entityName: "DefectEntity")
    }

    @NSManaged public var defectId: String?
    @NSManaged public var title: String?
    @NSManaged public var severity: String?
    @NSManaged public var priority: String?
    @NSManaged public var assignedToUserId: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var dateCreated: Date?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var user: UserEntity?
    @NSManaged public var requirements: NSSet?

    public var wrappedDefectId: String
    {
        defectId ?? Constants.EMPTY_STRING
    }

    public var wrappedTitle: String
    {
        title ?? Constants.EMPTY_STRING
    }

    public var wrappedSeverity: String
    {
        severity ?? Constants.EMPTY_STRING
    }

    public var wrappedPriority: String
    {
        priority ?? Constants.EMPTY_STRING
    }

    public var wrappedAssignedToUserId: String
    {
        assignedToUserId ?? Constants.EMPTY_STRING
    }

    public var wrappedUser: UserEntity
    {
        user ?? UserEntity()
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

extension DefectEntity
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

extension DefectEntity: Identifiable
{
}
