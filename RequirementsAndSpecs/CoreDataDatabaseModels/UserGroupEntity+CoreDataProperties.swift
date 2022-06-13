//
//  UserGroupEntity+CoreDataProperties.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 6/12/22.
//
//
import CoreData
import Foundation

extension UserGroupEntity
{
    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserGroupEntity>
    {
        return NSFetchRequest<UserGroupEntity>(entityName: "UserGroupEntity")
    }

    @NSManaged public var groupId: String?
    @NSManaged public var groupName: String?
    @NSManaged public var dateCreated: Date?
    @NSManaged public var lastUpdated: Date?
    @NSManaged public var users: NSSet?
    @NSManaged public var projects: NSSet?

    public var wrappedGroupId: String
    {
        groupId ?? Constants.EMPTY_STRING
    }

    public var wrappedGroupName: String
    {
        groupName ?? Constants.EMPTY_STRING
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

// MARK: Generated accessors for users

extension UserGroupEntity
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

// MARK: Generated accessors for projects

extension UserGroupEntity
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

extension UserGroupEntity: Identifiable
{
}
