//
//  LoginViewModel.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 5/22/22.
//
import Foundation
import SwiftUI

class LoginViewModel: ObservableObject
{
    @AppStorage("AUTH_KEY") var authenticated = false
    {
        willSet { objectWillChange.send() }
    }

    @AppStorage("USER_KEY") var username = ""
    
    @Published var password = "" // Keep filled ONLY for debugging
    @Published var invalid: Bool = false

    private var sampleUser = "username"
    private var samplePassword = "password"

    init()
    {
        // Debugging
        Log.info("Currently logged on: \(authenticated)")
        Log.info("Current user: \(username)")
    }

    func toggleAuthentication()
    {
        // Make sure that the password does not save.
        password = ""

        withAnimation(.spring())
        {
            authenticated.toggle()
        }
    }

    func authenticate()
    {
        // Check for user
        guard username.lowercased() == sampleUser
        else
        {
            invalid = true
            return
        }

        // Check for password
        guard password.lowercased() == samplePassword
        else
        {
            invalid = true
            return
        }

        toggleAuthentication()
    }

    func logOut()
    {
        toggleAuthentication()
    }

    func logPressed()
    {
        print("Button pressed.")
    }
}
