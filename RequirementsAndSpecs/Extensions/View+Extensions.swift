//
//  View+Extensions.swift
//  RequirementsAndSpecs
//
//  Created by Larry Burris on 2/8/22.
//  Copyright © 2022 Larry Burris. All rights reserved.
//
import Foundation
import SwiftUI

extension View
{
    func embedInNavigationView() -> some View
    {
        NavigationView { self }
    }
}
