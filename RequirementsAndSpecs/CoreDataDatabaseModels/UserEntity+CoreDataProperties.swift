//
//  UserEntity+CoreDataProperties.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
//
import CoreData
import Foundation

extension UserEntity
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity>
    {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var userId: String?
    @NSManaged public var userName: String?
    @NSManaged public var password: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var roles: NSSet?
    @NSManaged public var defects: NSSet?
    @NSManaged public var requirements: NSSet?
    @NSManaged public var groups: NSSet?
    @NSManaged public var projects: NSSet?

    public var wrappedUserId: String
    {
        userId ?? Constants.EMPTY_STRING
    }

    public var wrappedUserName: String
    {
        userName ?? Constants.EMPTY_STRING
    }

    public var wrappedPassword: String
    {
        password ?? Constants.EMPTY_STRING
    }

    public var roleArray: [RoleEntity]
    {
        let set = roles as? Set<RoleEntity> ?? []

        return set.sorted
        {
            $0.wrappedRoleId < $1.wrappedRoleId
        }
    }

    public var defectArray: [DefectEntity]
    {
        let set = defects as? Set<DefectEntity> ?? []

        return set.sorted
        {
            $0.wrappedDefectId < $1.wrappedDefectId
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

    public var projectArray: [ProjectEntity]
    {
        let set = projects as? Set<ProjectEntity> ?? []

        return set.sorted
        {
            $0.wrappedProjectId < $1.wrappedProjectId
        }
    }
}

// MARK: Generated accessors for roles

extension UserEntity
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

// MARK: Generated accessors for defects

extension UserEntity
{
    @objc(addDefectsObject:)
    @NSManaged public func addToDefects(_ value: DefectEntity)

    @objc(removeDefectsObject:)
    @NSManaged public func removeFromDefects(_ value: DefectEntity)

    @objc(addDefects:)
    @NSManaged public func addToDefects(_ values: NSSet)

    @objc(removeDefects:)
    @NSManaged public func removeFromDefects(_ values: NSSet)
}

// MARK: Generated accessors for requirements

extension UserEntity
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

extension UserEntity
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

// MARK: Generated accessors for projects

extension UserEntity
{
    @objc(addProjectsObject:)
    @NSManaged public func addToProjects(_ value: ProjectEntity)

    @objc(removeProjectsObject:)
    @NSManaged public func removeFromProjects(_ value: ProjectEntity)

    @objc(addProjects:)
    @NSManaged public func addToProjects(_ values: NSSet)

    @objc(removeProjects:)
    @NSManaged public func removeFromProjects(_ values: NSSet)
}

extension UserEntity: Identifiable
{
}
