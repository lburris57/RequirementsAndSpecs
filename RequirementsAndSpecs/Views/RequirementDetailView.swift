//
//  RequirementDetailView.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import CoreData
import SwiftUI

struct RequirementDetailView: View
{
    @StateObject private var requirementDetailViewModel = RequirementDetailViewModel()
    
    @State private var isPresented: Bool = false
    @State private var showingAlert: Bool = false
    @State var commentListCount: Int = 0

    var requirement: Requirement
    
    private func deleteComment(at indexSet: IndexSet)
    {
        // Delete the comment only if there are more than one
        if commentListCount > 1
        {
            indexSet.forEach
            {
                index in
                
                let comment = requirement.comments[index]

                // Delete the comment
                requirementDetailViewModel.deleteComment(comment)
                
                // Refresh the requirements list in the view model
                loadRequirement()
            }
        }
        else
        {
            showingAlert = true
        }
    }
    
    //  Evaluates whether the required fields are populated
    private func evaluateFields() -> Bool
    {
        return true
    }
    
    func loadRequirement()
    {
        requirementDetailViewModel.retrieveRequirement(requirement.requirementId)
    }
    
    func setCommentCount()
    {
        commentListCount = requirement.comments.count
        
        Log.info("Number of comments in comment list is: \(commentListCount)")
    }
    
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
        VStack
        {
            VStack
            {
                VStack(alignment: .leading, spacing: 8)
                {
                    Group
                    {
                        VStack
                        {
                            HStack
                            {
                                Text("Requirement Id:").fontWeight(.bold)
                                Spacer()
                            }
                            
                            HStack
                            {
                                Text("\(requirement.requirementId)").foregroundColor(Color.secondary)
                                Spacer()
                            }
                        }

                        VStack(alignment: .leading)
                        {
                            HStack
                            {
                                Text("Title:").fontWeight(.bold)
                                Spacer()
                            }
                            
                            HStack
                            {
                                Text("\(requirement.title)").foregroundColor(Color.secondary)
                                Spacer()
                            }
                        }

                        VStack(alignment: .leading)
                        {
                            HStack
                            {
                                Text("Description: ").fontWeight(.bold)
                                Spacer()
                            }
                                
                            HStack
                            {
                                Text("\(requirement.descriptionText)").foregroundColor(Color.secondary).lineLimit(0)
                                Spacer()
                            }
                        }

                        VStack
                        {
                            HStack
                            {
                                Text("Status: ").fontWeight(.bold)
                                Spacer()
                            }
                                
                            HStack
                            {
                                Text("\(requirement.status)").foregroundColor(Color.secondary)
                                Spacer()
                            }
                        }

                        VStack
                        {
                            HStack
                            {
                                Text("Category: ").fontWeight(.bold)
                                Spacer()
                            }
                                
                            HStack
                            {
                                Text("\(requirement.category)").foregroundColor(Color.secondary)
                                Spacer()
                            }
                        }
                    }
                
                    Group
                    {
                        VStack
                        {
                            HStack
                            {
                                Text("Priority: ").fontWeight(.bold)
                                Spacer()
                            }
                                
                            HStack
                            {
                                Circle()
                                .fill(styleForPriority(requirement.priority))
                                .frame(width: 15, height: 15)
                                Text("\(requirement.priority)").foregroundColor(Color.secondary)
                                Spacer()
                            }
                        }

                        VStack
                        {
                            HStack
                            {
                                Text("Complexity: ").fontWeight(.bold)
                                Spacer()
                            }
                                
                            HStack
                            {
                                Text("\(requirement.complexity)").foregroundColor(Color.secondary)
                                Spacer()
                            }
                        }

                        if(requirement.relatedDocuments != Constants.EMPTY_STRING)
                        {
                            VStack
                            {
                                HStack
                                {
                                    Text("Related Documents: ").fontWeight(.bold)
                                    Spacer()
                                }
                                    
                                HStack
                                {
                                    Text("\(requirement.relatedDocuments)").foregroundColor(Color.secondary)
                                    Spacer()
                                }
                            }
                        }

                        if(requirement.unitTestId != Constants.EMPTY_STRING)
                        {
                            VStack
                            {
                                HStack
                                {
                                    Text("Unit Test Id: ").fontWeight(.bold)
                                    Spacer()
                                }
                                    
                                HStack
                                {
                                    Text("\(requirement.unitTestId)").foregroundColor(Color.secondary)
                                    Spacer()
                                }
                            }
                        }

                        if(requirement.behavioralTestId != Constants.EMPTY_STRING)
                        {
                            VStack
                            {
                                HStack
                                {
                                    Text("Behavioral Test Id: ").fontWeight(.bold)
                                    Spacer()
                                }
                                    
                                HStack
                                {
                                    Text("\(requirement.behavioralTestId)").foregroundColor(Color.secondary)
                                    Spacer()
                                }
                            }
                        }
                    }

                    Group
                    {
                        VStack
                        {
                            HStack
                            {
                                Text("Group: ").fontWeight(.bold)
                                Spacer()
                            }
                                
                            HStack
                            {
                                Text("\(requirement.group == Constants.EMPTY_STRING ? "Bubba" : requirement.group)").foregroundColor(Color.secondary)
                                Spacer()
                            }
                        }
                        
                        VStack
                        {
                            HStack
                            {
                                Text("Last Updated: ").fontWeight(.bold)
                                Spacer()
                            }
                                
                            HStack
                            {
                                Text("\(requirement.lastUpdated)").foregroundColor(Color.secondary)
                                Spacer()
                            }
                        }
                    }

                }.navigationTitle("Requirement Details")
                .navigationBarTitleDisplayMode(.inline)
                .padding(8)
                .toolbar
                {
                    //  Only display the Edit button if more than one comment
                    ToolbarItemGroup(placement: .navigationBarTrailing)
                    {
                        commentListCount > 1 ? EditButton() : nil
                    }
                    
                    ToolbarItemGroup(placement: .bottomBar)
                    {
                        HStack
                        {
                            Button("Add Comment")
                            {
                                isPresented = true
                            }
                            
                            Button("Edit Requirement")
                            {
                                //  Add edit view here
                                print("Edit tapped!")
                            }
                        }
                    }
                }
                    //  Add multiple full screen covers where needed
                .fullScreenCover(isPresented: $isPresented, onDismiss:
                {
                    loadRequirement()
                }, content:
                {
                    AddCommentView(requirement: requirement)
                })
            }
            .listStyle(.plain)
            
            
            VStack
            {
                HStack
                {
                    Text("Comments:").fontWeight(.bold).padding(8)

                    Spacer()
                }

                if requirement.comments.count == 0
                {
                    VStack
                    {
                        HStack
                        {
                            Text("There are no comments to display.").padding(8).foregroundColor(Color.secondary)
                        }
                    }
                }
                else
                {
                    List
                    {
                        //  Spin through the comment list and generate
                        //  a link to the comment update view for each cell as well
                        //  as provide a way for the user to delete the
                        //  selected comment
                        ForEach(requirement.comments, id: \.commentId)
                        {
                            comment in

                            NavigationLink(destination: Text("\(comment.title)\n\n\(comment.commentText)!").padding().font(.caption).foregroundColor(Color.secondary))
                            {
                                HStack
                                {
                                    VStack(alignment: .leading, spacing: 5)
                                    {
                                        VStack(alignment: .leading, spacing: 5)
                                        {
                                            Text("\(comment.title)").font(.headline)
                                        }

                                        VStack(alignment: .leading, spacing: 5)
                                        {
                                            Text("\(comment.commentText)").font(.caption).foregroundColor(Color.secondary)
                                        }
                                    }
                                }
                            }
                        }.onDelete(perform: deleteComment)
                        .alert("Error Deleting Comment", isPresented: $showingAlert)
                        {
                            Button("OK") {}
                            Button("Edit Comment") {}
                        }
                        message:
                        {
                            Text("There must be at least two comments in the list to activate the delete functionality!\n\nPlease edit the existing comment.")
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
        .padding()
        .onAppear(perform: setCommentCount)
    }
}
