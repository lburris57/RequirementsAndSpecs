//
//  RequirementCell.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import SwiftUI

//  Represents a cell in a table
struct RequirementCell: View
{
    let requirement: RealmRequirement
    
    //  Returns the color based on the priority
    private func styleForPriority(_ value: String) -> Color
    {
        let priority = Priority(rawValue: value)
        
        switch priority
        {
            case .low:
                return .green
            case .medium:
                return .orange
            case .high:
                return .red
            default:
                return .blue
        }
    }

    var body: some View
    {
        HStack
        {
            VStack(alignment: .leading, spacing: 5)
            {
                HStack
                {
                    Circle()
                    .fill(styleForPriority(requirement.priority))
                    .frame(width: 15, height: 15)
                    
                    Text("\(requirement.requirementId) \(requirement.title)")
                        .fontWeight(.bold)
                }
                
                Text("Category: \(requirement.category)")
                    .font(.caption)
                
                Text("Status: \(requirement.status)")
                    .font(.caption)
                
                Text("Group: \(requirement.group)")
                    .font(.caption)

                Text("Last updated: \(requirement.lastUpdated)")
                    .font(.caption2)
            }
            
            Spacer()
        }
    }
}
