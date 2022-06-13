//
//  RequirementListView.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import SwiftUI
import Inject

// Enums
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
    case lastUpdated = "Last Updated"
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
            case .lastUpdated:
                return "Last Updated"
        }
    }
}

struct RequirementListView: View
{
    @ObserveInjection var inject
    
    @StateObject var requirementListViewModel = RequirementListViewModel()

    @State private var isPresented: Bool = false
    @State private var showingAlert: Bool = false
    @State private var showSearchCriteria: Bool = false
    @State private var selectedSearchType: SearchType = .requirementId
    @State private var searchText = Constants.EMPTY_STRING
    @State var requirementListCount: Int = 0
    
    init()
    {
        Inject.animation = .interactiveSpring()
    }
    
    private func deleteRequirement(at indexSet: IndexSet)
    {
        // Delete the requirement only if there are more than one
        if requirementListCount > 1
        {
            indexSet.forEach
            {
                index in

                let requirement = requirementListViewModel.requirements[index]

                requirementListViewModel.deleteRequirement(requirement)

                // Refresh the requirements list in the view model
                requirementListViewModel.retrieveRequirementList()
            }
        }
        else
        {
            showingAlert = true
        }
    }
    
    func presentAddRequirementView()
    {
        isPresented = true
    }
    
    func setRequirementCount()
    {
        requirementListCount = requirementListViewModel.requirements.count
    }
    
    var body: some View
    {
        VStack
        {
            if requirementListViewModel.requirements.count == 0
            {
                List
                {
                    VStack(alignment: .center)
                    {
                        Text("There are no requirements to display.")
                    }
                    .padding()
                }
                .listStyle(.plain)
            }
            else
            {
                VStack(spacing: 0)
                {
                    HStack
                    {
                        Text(" Select Filter Type:").foregroundColor(Color.secondary)

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
                }
                
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
                    .alert("Error Deleting Requirement", isPresented: $showingAlert)
                    {
                        Button("OK") {}
                        Button("Edit Requirement") {}
                    }
                    message:
                    {
                        Text("There must be at least two requirements in the list to activate the delete functionality!\n\nPlease edit the existing requirement.")
                    }
                }
                .listStyle(.plain)
            }
        }
        .searchable(text: $searchText, prompt: "Filter by \(selectedSearchType.rawValue.lowercased())...")
        .navigationTitle("Requirements")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar
        {
            ToolbarItemGroup(placement: .navigationBarTrailing)
            {
                HStack
                {
                    //  Only display the Edit button if more than one requirement
                    requirementListCount > 1 ? EditButton() : nil
                    
                    Button(action: presentAddRequirementView)
                    {
                        Label("Add Requirement", systemImage: "plus.circle.fill").foregroundColor(.blue)
                    }
                }
            }
        }
        .onAppear(perform: setRequirementCount)
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
        .enableInjection()
    }
    
    var filteredRequirements: [RealmRequirement]
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
                    return filteredRequirements.filter {$0.requirementId.lowercased().contains(searchText.lowercased())}
                case .title:
                    return filteredRequirements.filter {$0.title.lowercased().contains(searchText.lowercased())}
                case .description:
                    return filteredRequirements.filter {$0.descriptionText.lowercased().contains(searchText.lowercased())}
                case .group:
                    return filteredRequirements.filter {$0.group.lowercased().contains(searchText.lowercased())}
                case .status:
                    return filteredRequirements.filter {$0.status.lowercased().contains(searchText.lowercased())}
                case .category:
                    return filteredRequirements.filter {$0.category.lowercased().contains(searchText.lowercased())}
                case .priority:
                    return filteredRequirements.filter {$0.priority.lowercased().contains(searchText.lowercased())}
                case .complexity:
                    return filteredRequirements.filter {$0.complexity.lowercased().contains(searchText.lowercased())}
                case .lastUpdated:
                    return filteredRequirements.filter {$0.lastUpdated.lowercased().contains(searchText.lowercased())}
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
