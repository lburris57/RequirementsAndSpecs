//
//  LoginView.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 5/22/22.
//

import SwiftUI

struct LoginView: View
{
    @Environment(\.managedObjectContext) var viewContext
    
    @StateObject var vm = LoginViewModel()

    var body: some View
    {
        if vm.authenticated
        {
            // Show the view you want users to see when logged on
            RequirementListView(requirementListViewModel: RequirementListViewModel(viewContext: viewContext))
        }
        else
        {
            // Show a login screen
            ZStack
            {
                Image("sky")
                    .resizable()
                    .cornerRadius(20)
                    .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 20)
                {
                    Spacer()
                    Text("Log in")
                        .foregroundColor(.white)
                        .font(.system(size: 40, weight: .medium, design: .rounded))
                        .underline()

                    TextField("Username", text: $vm.username)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $vm.password)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .privacySensitive()
                    HStack
                    {
                        Spacer()
//                        Button("Forgot password?", action: vm.logPressed)
//                            .tint(.red.opacity(0.80))
//                        Spacer()
                        Button("Log in", role: .cancel, action: vm.authenticate)
                            .buttonStyle(.bordered)
                        Spacer()
                    }
                    Spacer()
                }
                .alert("Access denied", isPresented: $vm.invalid)
                {
                    Button("Dismiss", action: vm.logPressed)
                }
                .frame(width: 300)
                .padding()
            }
            .transition(.offset(x: 0, y: 850))
        }
    }
}

struct LoginView_Previews: PreviewProvider
{
    static var previews: some View
    {
        LoginView()
    }
}
