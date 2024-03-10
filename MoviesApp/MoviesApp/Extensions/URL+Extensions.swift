//
//  URL+Extensions.swift
//  MoviesApp
//
//  Created by Hamed on 02/29/24.

import Foundation

extension URL {
    
    static func forMoviesByName(_ name: String) -> URL? {
        return URL(string: "http://www.omdbapi.com/?s=\(name)&apikey=\(Constants.API_KEY)")
    }
    
}
