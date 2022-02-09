//
//  DatabaseManager.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import Foundation
import RealmSwift

class DatabaseManager
{
    let shortDateFormatter = DateFormatter()
    let fullDateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    let dateStringFormatter = DateFormatter()
    
    let today = Date()
    
    //  Create a new Realm database
    static let realm = try! Realm()
    
    // MARK: Retrieve Functions
    static func retrieveAllRequirements() throws -> [Requirement]
    {
        var requirements = [Requirement]()
        
        do
        {
            try realm.write
            {
                requirements = convertToArray(results: realm.objects(Requirement.self))
            }
        }
        catch
        {
            Log.error("Error retrieving requirements list: \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.readFromDatabase
        }
        
        return requirements
    }
    
    static func retrieveRequirementById(_ requirementId: String) throws -> Requirement?
    {
        var requirement: Requirement?
            
        do
        {
            try realm.write
            {
                requirement = realm.objects(Requirement.self).filter("requirementId == '\(requirementId)'").first
            }
        }
        catch
        {
            Log.error("Error retrieving requirement \(requirementId): \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.readFromDatabase
        }
        
        return requirement
    }
    
    static func retrieveCommentsByRequirementId(_ requirementId: String) throws -> [Comment]
    {
        var comments = [Comment]()
            
        do
        {
            try realm.write
            {
                comments = convertToArray(results: realm.objects(Comment.self).filter("requirementId == '\(requirementId)'"))
            }
        }
        catch
        {
            Log.error("Error retrieving comments related to \(requirementId): \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.readFromDatabase
        }
        
        return comments
    }
    
    // MARK: Save/Update Functions
    static func saveRequirement(_ requirement: Requirement) throws
    {
        do
        {
            Log.info("Saving requirement \(requirement.requirementId)...")
            
            try realm.write
            {
                realm.add(requirement, update: .modified)
                
                Log.info("Requirement \(requirement.requirementId) has successfully been saved to the database!!")
            }
        }
        catch
        {
            Log.error("Error saving requirement \(requirement.requirementId) to the database: \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.saveToDatabase
        }
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    static func saveComment(_ comment: Comment) throws
    {
        var comments = [Comment]()
        
        var nextCommentId = 1
        
        do
        {
            Log.info("Saving \(comment.title)...")
            
            try realm.write
            {
                //  Retrieve the comment with the highest commentId number, add 1 and assign it to the new comment
                comments = convertToArray(results: realm.objects(Comment.self).sorted(by: \.commentId))
                
                if comments.count > 0
                {
                    nextCommentId = (Int(comments.last!.commentId) ?? 0) + 1
                }
                
                comment.commentId = String(nextCommentId)
                
                realm.add(comment, update: .modified)
                
                Log.info("\(comment.title) has successfully been saved to the database!!")
            }
            
            //  Link the comments to the requirement
            try linkCommentsToRequirement(comment.requirementId)
        }
        catch
        {
            Log.error("Error saving \(comment.title) to the database: \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.saveToDatabase
        }
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    // MARK: Delete Functions
    static func deleteRequirement(_ requirement: Requirement) throws
    {
        do
        {
            Log.info("Deleting requirement \(requirement.requirementId)...")
            
            try realm.write
            {
                realm.delete(requirement)
                
                Log.info("Requirement \(requirement.requirementId) has successfully been deleted from the database!!")
            }
        }
        catch
        {
            Log.error("Error deleting requirement \(requirement.requirementId) to the database: \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.saveToDatabase
        }
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    static func deleteComment(_ comment: Comment) throws
    {
        do
        {
            Log.info("Deleting \(comment.title)...")
            
            try realm.write
            {
                realm.delete(comment)
                
                Log.info("\(comment.title) has successfully been deleted from the database!!")
            }
        }
        catch
        {
            Log.error("Error deleting \(comment.title) to the database: \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.saveToDatabase
        }
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    // MARK: Linking Functions
    static func linkCommentsToRequirement(_ requirementId: String) throws
    {
        //  Retrieve all comments based on the requirementId, retrieve the requirement object and assign the comments and save the requirement object
        do
        {
            let comments = try retrieveCommentsByRequirementId(requirementId)
            
            if let requirement = try retrieveRequirementById(requirementId)
            {
                try realm.write
                {
                    requirement.comments.append(objectsIn: comments)
                    
                    realm.add(requirement, update: .modified)
                
                    Log.info("Comments have successfully been linked to requirement \(requirementId)!!")
                }
            }
        }
        catch
        {
            Log.error("Error linking comments to requirement \(requirementId) to the database: \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.saveToDatabase
        }
    }
    
    //  Converts a Realm Results<R> object into an array of Realm objects of that type
    private static func convertToArray<R>(results: Results<R>) -> [R] where R: Object
    {
        var arrayOfResults: [R] = []
        
        for result in results
        {
            arrayOfResults.append(result)
        }
        
        return arrayOfResults
    }
}
