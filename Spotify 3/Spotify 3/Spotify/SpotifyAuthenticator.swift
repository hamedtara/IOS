//
//  SpotifyAuthenticator.swift
//  Spotify
//
//  Created by user234266 on 11/26/23.
//

import Foundation

class SpotifyAuthenticator {
    // Replace these with your Spotify client credentials
    private let clientID = "*"
    private let clientSecret = "*"

    /// This method fetches an access token from the Spotify API
    /// - Parameter completion: A closure that is called with the Result type, containing either a String (the access token) or an Error.
    func getAccessToken(completion: @escaping (Result<String, Error>) -> Void) {
        // The URL for the Spotify Accounts authentication endpoint
        guard let tokenURL = URL(string: "https://accounts.spotify.com/api/token") else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        // Set up the POST request with appropriate URL and HTTP method
        var request = URLRequest(url: tokenURL)
        request.httpMethod = "POST"
        
        // The body parameters required for client credentials grant type
        let bodyParameters = "grant_type=client_credentials".data(using: .utf8)
        
        // Encode the client ID and client secret to Base64 for the Authorization header
        let credentials = "\(clientID):\(clientSecret)".data(using: .utf8)?.base64EncodedString() ?? ""
        
        // Set the request's body and headers
        request.httpBody = bodyParameters
        request.setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Create a data task to handle the HTTP request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle the HTTP response: data contains the response data, error contains any error that occurred
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Network request failed"])))
                return
            }
            
            // Try to decode the data into a JSON format
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let accessToken = json["access_token"] as? String {
                    // If successful, call the completion with the access token
                    completion(.success(accessToken))
                } else {
                    // If the JSON structure doesn't match our expectations or the access token isn't found, call the completion with an error
                    completion(.failure(NSError(domain: "", code: 2, userInfo: [NSLocalizedDescriptionKey: "JSON parsing failed"])))
                }
            } catch {
                // If JSON parsing throws an error, pass this error to the completion handler
                completion(.failure(error))
            }
        }
        // Start the HTTP request
        task.resume()
    }
}

