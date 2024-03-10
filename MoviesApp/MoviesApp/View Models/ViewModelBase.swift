//
//  ViewModelBase.swift
//  MoviesApp
//
//  Created by Hamed on 02/29/24.
import Foundation
import SwiftUI 

enum LoadingState {
    case loading, success, failed, none
}

class ViewModelBase: ObservableObject {
    @Published var loadingState: LoadingState = .none
}
