//
//  Shared Models .swift
//  Spotify
//
//  Created by user234266 on 11/25/23.
//

import Foundation

struct Artist: Codable {
    let external_urls: ExternalURLs
    let href: String
    let id: String
    let name: String
    let type: String
    let uri: String
}

struct SpotifyImage: Codable {
    let url: String
    let height: Int?
    let width: Int?
}

struct ExternalURLs: Codable {
    let spotify: String
}

struct ExternalIDs: Codable {
    let isrc: String
    // Include other ID types as needed
}


struct ArtistSearchResponse: Codable {
    let artists: ArtistsPage
}

struct ArtistsPage: Codable {
    let items: [Artist]
    // Include other paging-related properties if needed, such as 'next', 'previous', 'limit', 'total', etc.
}
