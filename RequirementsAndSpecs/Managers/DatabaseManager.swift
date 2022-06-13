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
    let today = Date()
    
    //  Create a new Realm database
    static let realm = try! Realm()
    
    // MARK: Retrieve Functions
    static func retrieveAllRequirements() throws -> [RealmRequirement]
    {
        var requirements = [RealmRequirement]()
        
        do
        {
            try realm.write
            {
                requirements = convertToArray(results: realm.objects(RealmRequirement.self))
            }
        }
        catch
        {
            Log.error("Error retrieving requirement list: \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.readFromDatabase
        }
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        return requirements
    }
    
    static func retrieveAllComments() throws -> [RealmComment]
    {
        var comments = [RealmComment]()
        
        do
        {
            try realm.write
            {
                comments = convertToArray(results: realm.objects(RealmComment.self))
            }
        }
        catch
        {
            Log.error("Error retrieving comment list: \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.readFromDatabase
        }
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        return comments
    }
    
    static func retrieveRequirementById(_ requirementId: String) throws -> RealmRequirement?
    {
        var requirement: RealmRequirement?
            
        do
        {
            try realm.write
            {
                requirement = realm.objects(RealmRequirement.self).filter("requirementId == '\(requirementId)'").first
            }
        }
        catch
        {
            Log.error("Error retrieving requirement \(requirementId): \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.readFromDatabase
        }
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        return requirement
    }
    
    static func retrieveCommentsByRequirement(_ requirement: RealmRequirement) throws -> [RealmComment]
    {
        var comments = [RealmComment]()
            
        do
        {
            try realm.write
            {
                comments = convertToArray(results: realm.objects(RealmComment.self).filter("requirementId == '\(requirement.requirementId)'"))
            }
        }
        catch
        {
            Log.error("Error retrieving comments related to \(requirement.requirementId): \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.readFromDatabase
        }
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        return comments
    }
    
    static func retrieveCommentsByRequirementId(_ requirementId: String) throws -> [RealmComment]
    {
        var comments = [RealmComment]()
            
        do
        {
            try realm.write
            {
                comments = convertToArray(results: realm.objects(RealmComment.self).filter("requirementId == '\(requirementId)'"))
            }
        }
        catch
        {
            Log.error("Error retrieving comments related to \(requirementId): \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.readFromDatabase
        }
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        return comments
    }
    
    // MARK: Save/Update Functions
    static func saveRequirement(_ requirement: RealmRequirement) throws
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
        
        try linkCommentsToRequirements()
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    static func saveComment(_ comment: RealmComment) throws
    {
        var comments = [RealmComment]()
        
        var nextCommentId = 1
        
        do
        {
            Log.info("Saving \(comment.title)...")
            
            try realm.write
            {
                //  Retrieve the comment with the highest commentId number, add 1 and assign it to the new comment
                comments = convertToArray(results: realm.objects(RealmComment.self).sorted(by: \.commentId))
                
                if comments.count > 0
                {
                    nextCommentId = (Int(comments.last!.commentId) ?? 0) + 1
                }
                
                comment.commentId = String(nextCommentId)
                
                realm.add(comment, update: .modified)
                
                Log.info("\(comment.title) has successfully been saved to the database!!")
            }
            
            //  Link the comments to the requirement
            try linkCommentsToRequirements()
        }
        catch
        {
            Log.error("Error saving \(comment.title) to the database: \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.saveToDatabase
        }
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    // MARK: Delete Functions
    static func deleteRequirement(_ requirement: RealmRequirement) throws
    {
        let requirementId = requirement.requirementId
        
        do
        {
            Log.info("Deleting requirement \(requirementId)...")
            
            try realm.write
            {
                let comments = convertToArray(results: realm.objects(RealmComment.self).filter("requirementId == '\(requirementId)'"))
                
                realm.delete(comments)
                realm.delete(requirement)
                
                Log.info("Requirement \(requirementId) has successfully been deleted from the database along with any associated comments!!")
            }
        }
        catch
        {
            Log.error("Error deleting requirement \(requirementId) from the database: \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.deleteFromDatabase
        }
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    static func deleteComment(_ comment: RealmComment) throws
    {
        let commentTitle = comment.title
        let requirementId = comment.requirementId
        
        do
        {
            Log.info("Deleting \(commentTitle)...")
            
            try realm.write
            {
                var fetchedComments = convertToArray(results: realm.objects(RealmComment.self).filter("requirementId == '\(requirementId)'"))
                
                Log.info("Count of fetchedComments is: \(fetchedComments.count)")
                
                let index = fetchedComments.firstIndex(of: comment)
                
                fetchedComments.remove(at: index ?? 0)
                
                Log.info("Count of fetchedComments after removal is: \(fetchedComments.count)")
                
                //  Delete the incoming comment
                realm.delete(comment)
                
                if let requirement = realm.objects(RealmRequirement.self).filter("requirementId == '\(requirementId)'").first
                {
                    //  Remove any existing comments from the requirement
                    requirement.commentList.removeAll()
                    
                    if fetchedComments.count > 0
                    {
                        //  Add the updated comment list to the requirement
                        requirement.commentList.append(objectsIn: fetchedComments)
                    }
                    
                    //  Update the requirement in the database
                    realm.add(requirement, update: .modified)
                }
                
                Log.info("\(commentTitle) has successfully been deleted from the database and the parent requirement has been updated with refreshed comment list!!")
            }
            
            try linkCommentsToRequirements()
        }
        catch
        {
            Log.error("Error deleting \(commentTitle) to the database: \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.deleteFromDatabase
        }
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    // MARK: Linking Functions
    static func linkCommentsToRequirement(_ requirementId: String) throws
    {
        //  Retrieve all comments based on the requirementId, retrieve the requirement object and assign the comments and save the requirement object
        do
        {
            var comments = try retrieveCommentsByRequirementId(requirementId)
            
            if let requirement = try retrieveRequirementById(requirementId)
            {
                try realm.write
                {
                    //  Remove any existing comments from the requirement
                    requirement.commentList.removeAll()
                    
                    if comments.count == 0
                    {
                        let comment = RealmComment()
                        
                        comment.requirementId = requirementId
                        
                        comments.append(comment)
                    }
                    
                    requirement.commentList.append(objectsIn: comments)
                    
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
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    static func linkCommentsToRequirements() throws
    {
        do
        {
            let requirements = try retrieveAllRequirements()
            let comments = try retrieveAllComments()
            
            if requirements.count == 0
            {
                return
            }
            
            try realm.write
            {
                for requirement in requirements
                {
                    let requirementId = requirement.requirementId
                    
                    if requirement.commentList.count > 0
                    {
                        //  Remove any existing comments from the requirement
                        requirement.commentList.removeAll()
                    }
                    
                    for comment in comments
                    {
                        if comment.requirementId == requirementId
                        {
                            requirement.commentList.append(comment)
                        }
                    }
                    
                    Log.info("Size of commentList in requirement \(requirement.requirementId) is: \(requirement.commentList.count)")
                    Log.info("Size of comments in requirement \(requirement.requirementId) is: \(requirement.comments.count)")
                    
                    realm.add(requirement, update: .modified)
                    
                    //  Remove any comments that are not linked to a requirement
                    let unlinkedComments = convertToArray(results: realm.objects(RealmComment.self).filter("requirementId == ''"))
                    
                    realm.delete(unlinkedComments)
                }

                Log.info("Comments have successfully been linked to requirements!!")
                Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
            }
        }
        catch
        {
            Log.error("Error linking comments to requirements: \(error.localizedDescription)")
            
            throw DatabaseErrorEnum.saveToDatabase
        }
        
        Log.info("\(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    //  Converts a Realm Results object into an array of Realm objects of that type
    static func convertToArray<R>(results: Results<R>) -> [R] where R: Object
    {
        var arrayOfResults: [R] = []
        
        for result in results
        {
            arrayOfResults.append(result)
        }
        
        return arrayOfResults
    }
    
    //  Converts a Realm List object into an array of Realm objects of that type
    static func convertToArrayFromList<R>(results: List<R>) -> [R]  where R: Object
    {
        var arrayOfResults: [R] = []
        
        for result in results
        {
            arrayOfResults.append(result)
        }
        
        return arrayOfResults
    }
}
