//
//  AlbumDetails.swift
//  Spotify
//
//  Created by user234266 on 12/3/23.
//

import Foundation
struct AlbumDetails: Codable {
    let name: String
    let artists: [Artist]
    let releaseDate: String
    let images: [SpotifyImage]


    private enum CodingKeys: String, CodingKey {
        case name
        case artists
        case releaseDate = "release_date"
        case images

    }
}
