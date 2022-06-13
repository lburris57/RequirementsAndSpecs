//
//  BaseModel.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 06/12/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import CoreData
import Foundation

protocol BaseModel where Self: NSManagedObject
{
    func save()
    func delete()
    static func byId<T: NSManagedObject>(id: NSManagedObjectID) -> T?
    static func all<T: NSManagedObject>() -> [T]
}

extension BaseModel
{
    static var viewContext: NSManagedObjectContext
    {
        return CoreDataManager.shared.persistentContainer.viewContext
    }

    func save()
    {
        do
        {
            try Self.viewContext.save()
        }
        catch
        {
            CoreDataManager.shared.persistentContainer.viewContext.rollback()

            Log.error("Error saving data: \(error.localizedDescription)")
        }
    }

    func delete()
    {
        Self.viewContext.delete(self)
        save()
    }

    static func all<T>() -> [T] where T: NSManagedObject
    {
        let fetchRequest: NSFetchRequest<T> = NSFetchRequest(entityName: String(describing: T.self))

        do
        {
            return try viewContext.fetch(fetchRequest)
        }
        catch
        {
            Log.error("Error retrieving all \(T.self) objects: \(error.localizedDescription)")

            return []
        }
    }

    static func byId<T>(id: NSManagedObjectID) -> T? where T: NSManagedObject
    {
        do
        {
            return try viewContext.existingObject(with: id) as? T
        }
        catch
        {
            Log.error("Error retrieving \(T.description()) by id): \(error.localizedDescription)")

            return nil
        }
    }
}

extension RequirementEntity: BaseModel
{
}

extension UserEntity: BaseModel
{
}

extension ProjectEntity: BaseModel
{
}

extension RoleEntity: BaseModel
{
}

extension UserGroupEntity: BaseModel
{
}

extension TestEntity: BaseModel
{
}

extension DefectEntity: BaseModel
{
}

extension CommentEntity: BaseModel
{
}

extension Date
{
    func asLongDateFormattedString() -> String
    {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = "EEEE, MMM d, yyyy hh:mm a"
        return formatter.string(from: self)
    }

    func asShortDateFormattedString() -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
}
