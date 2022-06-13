//
//  RoleEntity+CoreDataProperties.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
//
import CoreData
import Foundation

extension RoleEntity
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoleEntity>
    {
        return NSFetchRequest<RoleEntity>(entityName: "RoleEntity")
    }

    @NSManaged public var roleId: String?
    @NSManaged public var roleName: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var users: NSSet?
    @NSManaged public var projects: NSSet?

    public var wrappedRoleId: String
    {
        roleId ?? Constants.EMPTY_STRING
    }

    public var wrappedRoleName: String
    {
        roleName ?? Constants.EMPTY_STRING
    }

    public var userArray: [UserEntity]
    {
        let set = users as? Set<UserEntity> ?? []

        return set.sorted
        {
            $0.wrappedUserId < $1.wrappedUserId
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

// MARK: Generated accessors for project

extension RoleEntity
{
    @objc(addUserObject:)
    @NSManaged public func addToUsers(_ value: UserEntity)

    @objc(removeUserObject:)
    @NSManaged public func removeFromUsers(_ value: UserEntity)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)
}

// MARK: Generated accessors for project

extension RoleEntity
{
    @objc(addProjectObject:)
    @NSManaged public func addToProjects(_ value: ProjectEntity)

    @objc(removeProjectObject:)
    @NSManaged public func removeFromProjects(_ value: ProjectEntity)

    @objc(addProjects:)
    @NSManaged public func addToProjects(_ values: NSSet)

    @objc(removeProjects:)
    @NSManaged public func removeFromProjects(_ values: NSSet)
}

extension RoleEntity: Identifiable
{
}
