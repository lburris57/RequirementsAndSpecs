//
//  ProjectEntity+CoreDataProperties.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
//
import CoreData
import Foundation

extension ProjectEntity
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProjectEntity>
    {
        return NSFetchRequest<ProjectEntity>(entityName: "ProjectEntity")
    }

    @NSManaged public var projectId: String?
    @NSManaged public var title: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var createdBy: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var users: NSSet?
    @NSManaged public var requirements: NSSet?
    @NSManaged public var groups: NSSet?
    @NSManaged public var roles: NSSet?
    
    public var wrappedProjectId: String
    {
        projectId ?? Constants.EMPTY_STRING
    }

    public var wrappedTitle: String
    {
        title ?? Constants.EMPTY_STRING
    }

    public var wrappedDescriptionText: String
    {
        descriptionText ?? Constants.EMPTY_STRING
    }
    
    public var wrappedCreatedBy: String
    {
        createdBy ?? Constants.EMPTY_STRING
    }
    
    public var userArray: [UserEntity]
    {
        let set = users as? Set<UserEntity> ?? []

        return set.sorted
        {
            $0.wrappedUserId < $1.wrappedUserId
        }
    }
    
    public var requirementArray: [RequirementEntity]
    {
        let set = requirements as? Set<RequirementEntity> ?? []

        return set.sorted
        {
            $0.wrappedRequirementId < $1.wrappedRequirementId
        }
    }
    
    public var groupArray: [UserGroupEntity]
    {
        let set = groups as? Set<UserGroupEntity> ?? []

        return set.sorted
        {
            $0.wrappedGroupId < $1.wrappedGroupId
        }
    }
    
    public var roleArray: [RoleEntity]
    {
        let set = roles as? Set<RoleEntity> ?? []

        return set.sorted
        {
            $0.wrappedRoleId < $1.wrappedRoleId
        }
    }
}

// MARK: Generated accessors for users

extension ProjectEntity
{
    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: UserEntity)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: UserEntity)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)
}

// MARK: Generated accessors for requirements

extension ProjectEntity
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

// MARK: Generated accessors for groups

extension ProjectEntity
{
    @objc(addGroupsObject:)
    @NSManaged public func addToGroups(_ value: UserGroupEntity)

    @objc(removeGroupsObject:)
    @NSManaged public func removeFromGroups(_ value: UserGroupEntity)

    @objc(addGroups:)
    @NSManaged public func addToGroups(_ values: NSSet)

    @objc(removeGroups:)
    @NSManaged public func removeFromGroups(_ values: NSSet)
}

// MARK: Generated accessors for roles

extension ProjectEntity
{
    @objc(addRolesObject:)
    @NSManaged public func addToRoles(_ value: RoleEntity)

    @objc(removeRolesObject:)
    @NSManaged public func removeFromRoles(_ value: RoleEntity)

    @objc(addRoles:)
    @NSManaged public func addToRoles(_ values: NSSet)

    @objc(removeRoles:)
    @NSManaged public func removeFromRoles(_ values: NSSet)
}

extension ProjectEntity: Identifiable
{
}
