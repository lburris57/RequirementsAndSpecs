//
//  RequirementCell.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import SwiftUI

struct RequirementCell: View
{
    let requirement: Requirement
    
    //  Returns the color based on the priority
    private func styleForPriority(_ value: String) -> Color
    {
        let priority = Priority(rawValue: value)
        
        switch priority
        {
            case .low:
                return Color.green
            case .medium:
                return Color.orange
            case .high:
                return Color.red
            default:
                return Color.blue
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
