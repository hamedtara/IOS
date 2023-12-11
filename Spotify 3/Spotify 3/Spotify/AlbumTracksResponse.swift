//
//  AlbumTracksResponse.swift
//  Spotify
//
//  Created by user234266 on 12/3/23.
//
import Foundation

struct AlbumResponse: Codable {
    let album_type: String
    let total_tracks: Int
    let available_markets: [String]
    let external_urls: [String: String]
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let release_date: String
    let release_date_precision: String
    let restrictions: Restrictions?
    let type: String
    let uri: String
    let artists: [SpotifyArtist]
    let tracks: AlbumTracksResponse
}

struct AlbumTracksResponse: Codable {
    let href: String
    let items: [Track]
}

struct Track: Codable {
    let artists: [SpotifyArtist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let explicit: Bool
    let external_urls: [String: String]
    let href: String
    let id: String
    let is_playable: Bool?
    let linked_from: LinkedFrom?
    let restrictions: Restrictions?
    let name: String
    let preview_url: String?
    let track_number: Int
    let type: String
    let uri: String
    let is_local: Bool
}

struct SpotifyArtist: Codable {
    let external_urls: [String: String]
    let href: String
    let id: String
    let name: String
    let type: String
    let uri: String
}

struct SpotifyAlbum: Codable {

    let name: String
    let id: String
    let images: [Image]
}

struct Image: Codable {
    let url: String
    let height: Int?
    let width: Int?
}

struct Restrictions: Codable {
    let reason: String
}

struct LinkedFrom: Codable {
    let external_urls: [String: String]
    let href: String
    let id: String
    let type: String
    let uri: String
}
