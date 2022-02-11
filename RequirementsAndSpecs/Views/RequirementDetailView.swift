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

    var requirement: Requirement
    
    private func deleteComment(at indexSet: IndexSet)
    {
        indexSet.forEach
        {
            index in
            
            let comment = requirement.comments[index]

            // Delete the comment only if there are more than one comment
            if requirementDetailViewModel.requirement.comments.count > 1
            {
                // Delete the comment
                requirementDetailViewModel.deleteComment(comment)
                
                // Refresh the requirements list in the view model
                loadRequirement()
            }
            else
            {
                //  Show alert to the user
            }
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
                //  The following toolbar code will replace the navigation bar items code to place links across the bottom of the view
//                .toolbar
//                {
//                    ToolbarItemGroup(placement: .bottomBar)
//                    {
//                        Button("Edit Requirement")
//                        {
//
                            //  Add edit view here
                            //  print("Edit tapped!")
//                        }
//
//                        Button("Add Comment")
//                        {
//                            isPresented = true
//                            loadRequirement()
//                            AddCommentView(requirement: requirement)
//                        }
//                    }
//                }
                .navigationBarItems(trailing: Button("Add Comment")
                {
                    isPresented = true
                })
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
                        }
                        .onDelete(perform: deleteComment)
                    }
                }
            }
            .listStyle(.plain)
            
            
            
            
//            Button("Edit Requirement Information")
//            {
//                //saveRequirement()
//                //clearAllFields()
//                //presentationMode.wrappedValue.dismiss()
//
//            }
//            .padding(10)
//            .frame(maxWidth: .infinity)
//            .background(Color.blue).opacity(!evaluateFields() ? 0.6 : 1)
//            .foregroundColor(Color.white)
//            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
//            .shadow(color: .black, radius: 2.0, x: 2.0, y: 2.0)
//            .disabled(!evaluateFields())
            
            Spacer()
            
            
        }
        .padding()
    }
}
