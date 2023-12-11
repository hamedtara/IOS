//
//  spotifyService.swift
//  Spotify
//
//  Created by user234266 on 11/27/23.
//

import Foundation

class SpotifyService {
    private let baseURL = "https://api.spotify.com/v1"
    private let session = URLSession.shared
    private var accessToken: String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    // Function to fetch new releases from Spotify.
    func fetchNewReleases(completion: @escaping (Result<NewReleasesResponse, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/browse/new-releases")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "SpotifyService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Network request failed"])))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(NewReleasesResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    func fetchImageData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    func fetchAlbum(albumId: String, completion: @escaping (Result<AlbumResponse, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/albums/\(albumId)")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error: \(error)")
                completion(.failure(error))
                return
            }

            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                print("HTTP Error: \(httpResponse.statusCode)")
                completion(.failure(NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: nil)))
                return
            }

            guard let data = data else {
                print("No data received")
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                return
            }

            do {
                let decoder = JSONDecoder()
                let albumResponse = try decoder.decode(AlbumResponse.self, from: data)
                completion(.success(albumResponse))
            } catch {
                print("JSON decoding error: \(error)")
                completion(.failure(error))
            }
        }
        task.resume()
    }

}
 
