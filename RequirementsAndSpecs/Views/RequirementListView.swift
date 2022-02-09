//
//  RequirementListView.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import SwiftUI

enum SearchType: String, Identifiable, CaseIterable, Hashable
{
    var id: UUID
    {
        return UUID()
    }

    case requirementId = "Requirement Id"
    case title = "Title"
    case description = "Description"
    case group = "Group"
    case status = "Status"
    case category = "Category"
    case priority = "Priority"
    case complexity = "Complexity"
    
}

extension SearchType
{
    var searchType: String
    {
        switch self
        {
            case .requirementId:
                return "Requirement Id"
            case .title:
                return "Title"
            case .description:
                return "Description"
            case .group:
                return "Group"
            case .status:
                return "Status"
            case .category:
                return "Category"
            case .priority:
                return "Priority"
            case .complexity:
                return "Complexity"
        }
    }
}

struct RequirementListView: View
{
    @StateObject var requirementListViewModel = RequirementListViewModel()

    @State private var isPresented: Bool = false
    @State private var selectedSearchType: SearchType = .requirementId
    @State private var searchText = Constants.EMPTY_STRING
    
    var promptString = Constants.EMPTY_STRING

    private func deleteRequirement(at indexSet: IndexSet)
    {
        indexSet.forEach
        {
            index in

            let requirement = requirementListViewModel.requirements[index]

            // Delete the requirement
            requirementListViewModel.deleteRequirement(requirement)

            // Refresh the requirements list in the view model
            requirementListViewModel.retrieveRequirementList()
        }
    }
    
    var body: some View
    {
        VStack
        {
            if requirementListViewModel.requirements.count == 0
            {
                List
                {
                    Text("There are no requirements to display.")
                }
                .listStyle(.plain)
            }
            else
            {
                HStack
                {
                    Text(" Filter By:").foregroundColor(Color.secondary)

                    Picker("Search Type", selection: $selectedSearchType)
                    {
                        ForEach(SearchType.allCases)
                        {
                            searchType in

                            Text(searchType.searchType).tag(searchType)
                        }
                    }.pickerStyle(.menu)
                    

                    Spacer()

                }.padding(.horizontal)
                
                List
                {
                    //  Spin through the requirements list and generate
                    //  a link to the detail view for each cell as well
                    //  as provide a way for the user to delete the
                    //  selected requirement
                    ForEach(filteredRequirements, id: \.id)
                    {
                        requirement in

                        NavigationLink(destination: RequirementDetailView(requirement: requirement))
                        {
                            RequirementCell(requirement: requirement)
                        }
                    }
                    .onDelete(perform: deleteRequirement)
                    
                }
                .listStyle(.plain)
            }
        }
        .searchable(text: $searchText, prompt: "Filter by \(selectedSearchType.rawValue.lowercased())...")
        .navigationTitle("Requirements")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button("Add Requirement")
        {
            isPresented = true
        })
        .fullScreenCover(isPresented: $isPresented, onDismiss:
        {
            requirementListViewModel.retrieveRequirementList()
        }, content:
        {
            AddRequirementView()
        })
        .embedInNavigationView()
        .onAppear(perform:
        {
            requirementListViewModel.retrieveRequirementList()
        })
    }
    
    var filteredRequirements: [Requirement]
    {
        let filteredRequirements = requirementListViewModel.requirements
        
        if searchText.isEmpty
        {
            return filteredRequirements
        }
        else
        {
            switch selectedSearchType
            {
                case .requirementId:
                    return filteredRequirements.filter {$0.requirementId.contains(searchText)}
                case .title:
                    return filteredRequirements.filter {$0.title.contains(searchText)}
                case .description:
                    return filteredRequirements.filter {$0.descriptionText.contains(searchText)}
                case .group:
                    return filteredRequirements.filter {$0.group.contains(searchText)}
                case .status:
                    return filteredRequirements.filter {$0.status.contains(searchText)}
                case .category:
                    return filteredRequirements.filter {$0.category.contains(searchText)}
                case .priority:
                    return filteredRequirements.filter {$0.priority.contains(searchText)}
                case .complexity:
                    return filteredRequirements.filter {$0.complexity.contains(searchText)}
            }
        }
    }
}

struct RequirementListView_Previews: PreviewProvider
{
    static var previews: some View
    {
        RequirementListView()
    }
}
