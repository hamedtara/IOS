//
//  NewRelease.swift
//  Spotify
//
//  Created by user234266 on 11/25/23.
//

import Foundation

struct NewReleasesResponse: Codable {
    let albums: PaginatedAlbums
}

struct PaginatedAlbums: Codable {
    let href: String
    let items: [Album]
    let limit: Int
    let next: String?
    let offset: Int
    let previous: String?
    let total: Int
}

struct Album: Codable {
    let album_type: String
    let artists: [Artist]
    let available_markets: [String]
    let external_urls: ExternalURLs
    let href: String
    let id: String
    let images: [SpotifyImage]
    let name: String
    let release_date: String
    let release_date_precision: String
    let total_tracks: Int
    let type: String
    let uri: String
}
