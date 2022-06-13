//
//  RequirementEntity+CoreDataProperties.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
//
import CoreData
import Foundation

extension RequirementEntity
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RequirementEntity>
    {
        return NSFetchRequest<RequirementEntity>(entityName: "RequirementEntity")
    }

    @NSManaged public var requirementId: String?
    @NSManaged public var title: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var group: String?
    @NSManaged public var status: String?
    @NSManaged public var category: String?
    @NSManaged public var priority: String?
    @NSManaged public var complexity: String?
    @NSManaged public var functionalArea: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var isValidated: Bool
    @NSManaged public var createdBy: String?
    @NSManaged public var relatedDocuments: String?
    @NSManaged public var unitTestId: String?
    @NSManaged public var behaviorialTestId: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var comments: NSSet?
    @NSManaged public var user: UserEntity?
    @NSManaged public var project: ProjectEntity?
    @NSManaged public var test: TestEntity?
    @NSManaged public var defect: DefectEntity?

    public var wrappedRequirementId: String
    {
        requirementId ?? Constants.EMPTY_STRING
    }

    public var wrappedTitle: String
    {
        title ?? Constants.EMPTY_STRING
    }

    public var wrappedDescriptionText: String
    {
        descriptionText ?? Constants.EMPTY_STRING
    }

    public var wrappedGroup: String
    {
        group ?? Constants.EMPTY_STRING
    }

    public var wrappedStatus: String
    {
        status ?? Constants.EMPTY_STRING
    }

    public var wrappedCategory: String
    {
        category ?? Constants.EMPTY_STRING
    }

    public var wrappedPriority: String
    {
        priority ?? Constants.EMPTY_STRING
    }

    public var wrappedComplexity: String
    {
        complexity ?? Constants.EMPTY_STRING
    }

    public var wrappedFunctionalArea: String
    {
        functionalArea ?? Constants.EMPTY_STRING
    }

    public var wrappedCreatedBy: String
    {
        createdBy ?? Constants.EMPTY_STRING
    }

    public var wrappedRelatedDocuments: String
    {
        relatedDocuments ?? Constants.EMPTY_STRING
    }

    public var wrappedUnitTestId: String
    {
        unitTestId ?? Constants.EMPTY_STRING
    }

    public var wrappedBehavioralTestId: String
    {
        behaviorialTestId ?? Constants.EMPTY_STRING
    }

    public var wrappedUser: UserEntity
    {
        user ?? UserEntity()
    }

    public var wrappedProject: ProjectEntity
    {
        project ?? ProjectEntity()
    }

    public var wrappedTest: TestEntity
    {
        test ?? TestEntity()
    }

    public var wrappedDefect: DefectEntity
    {
        defect ?? DefectEntity()
    }

    public var commentArray: [CommentEntity]
    {
        let set = comments as? Set<CommentEntity> ?? []

        return set.sorted
        {
            $0.wrappedCommentId < $1.wrappedCommentId
        }
    }
}

// MARK: Generated accessors for comments

extension RequirementEntity
{
    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: CommentEntity)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: CommentEntity)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)
}

extension RequirementEntity: Identifiable
{
}
