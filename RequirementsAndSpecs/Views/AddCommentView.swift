//
//  AddCommentView.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import SwiftUI

struct AddCommentView: View
{
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var addCommentViewModel = AddCommentViewModel()
    
    @State private var title = Constants.EMPTY_STRING
    @State private var description = Constants.EMPTY_STRING
    
    var requirement: Requirement
    
    //  Creates a new Requirement object, populates the values and calls the view model to save it to the database
    private func saveComment()
    {
        let comment = Comment()
            
        comment.requirementId = requirement.requirementId
        comment.title = title.capitalized
        comment.commentText = description
        comment.dateCreated = Date().asFormattedString()
        comment.lastUpdated = Date().asFormattedString()
        
        addCommentViewModel.saveComment(comment)
    }
    
    private func clearAllFields()
    {
        title = Constants.EMPTY_STRING
        description = Constants.EMPTY_STRING
    }
    
    //  Evaluates whether the required fields are populated
    private func evaluateFields() -> Bool
    {
        if title == Constants.EMPTY_STRING || description == Constants.EMPTY_STRING
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    var body: some View
    {
        NavigationView
        {
            VStack(alignment: .leading, spacing: 10)
            {
                Group
                {
                    VStack(alignment: .leading)
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
                    .padding(5)

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
                    .padding(5)

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
                    .padding(5)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 5)
                    {
                        TextField("Enter title", text: $title)
                            .textFieldStyle(.roundedBorder)
                        
                        Text(" Enter Comment:")
                        
                        TextEditor(text: $description)
                        .lineLimit(10)
                        .border(.secondary, width: 1)
                        
                        Spacer()
                        
                        Button("Save Comment")
                        {
                            saveComment()
                            clearAllFields()
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                        .padding(10)
                        .frame(maxWidth: .infinity)
                        .background(Color.blue).opacity(!evaluateFields() ? 0.6 : 1)
                        .foregroundColor(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                        .shadow(color: .black, radius: 2.0, x: 2.0, y: 2.0)
                        .disabled(!evaluateFields())
                    }
                }
                .navigationTitle("Add Comment")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: Button("Cancel")
                {
                    presentationMode.wrappedValue.dismiss()
                })
                .padding(8)
                .background(.ultraThinMaterial)
            }
        }
    }
}

struct AddCommentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        AddCommentView(requirement: RequirementListViewModel().requirements.count > 0 ? RequirementListViewModel().requirements[0] : Requirement())
    }
}
