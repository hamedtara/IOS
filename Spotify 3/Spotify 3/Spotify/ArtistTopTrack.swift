//
//  ArtistTopTrack.swift
//  Spotify
//
//  Created by user234266 on 11/25/23.
//

import Foundation

struct ArtistTopTracksResponse: Codable {
    let tracks: [TopTrack]
}

struct TopTrack: Codable {
    let album: Album
    let artists: [Artist]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_ids: ExternalIDs
    let external_urls: ExternalURLs
    let href: String
    let id: String
    let is_playable: Bool?
    let linked_from: LinkedTrack?
    let name: String
    let popularity: Int
    let preview_url: String?
    let track_number: Int
    let type: String
    let uri: String
    let available_markets: [String]? 

}

struct LinkedTrack: Codable {
    let external_urls: ExternalURLs
    let href: String
    let id: String
    let type: String
    let uri: String
}


