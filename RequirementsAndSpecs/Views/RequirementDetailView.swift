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

    var body: some View
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
                            Text("\(requirement.descriptionText)").foregroundColor(Color.secondary)
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
            .navigationBarItems(trailing: Button("Add Comment")
            {
                isPresented = true
            })
            .fullScreenCover(isPresented: $isPresented, onDismiss:
            {
                
            }, content:
            {
                AddCommentView(requirement: requirement)
            })
            
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
                            
                            Spacer()
                        }
                        
                        Spacer()
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
                                            Text("Title: ").font(.footnote)
                                            Text("\(comment.title)").font(.caption).foregroundColor(Color.secondary)
                                        }

                                        VStack(alignment: .leading, spacing: 5)
                                        {
                                            Text("Comment Text: ").font(.footnote)
                                            Text("\(comment.commentText)").font(.caption).foregroundColor(Color.secondary)
                                        }
                                    }
                                    
                                    Spacer()
                                }
                            }
                        }
                        //.onDelete(perform: deleteRequirement)
                    }
                }
                
                Spacer()
                
            }
            .listStyle(.plain)
        }
        .padding()
    }
}
