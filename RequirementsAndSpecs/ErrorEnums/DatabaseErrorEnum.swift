//
//  DatabaseErrorEnum.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import Foundation

enum DatabaseErrorEnum: Error
{
    case saveToDatabase
    case readFromDatabase
    case deleteFromDatabase
}
