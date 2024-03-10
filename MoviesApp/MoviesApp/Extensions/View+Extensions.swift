//
//  View+Extensions.swift
//  MoviesApp
//
//  Created by Hamed on 02/29/24.

import Foundation
import SwiftUI

extension View {
    
    func embedNavigationView() -> some View {
        return NavigationView { self }
    }
    
}
