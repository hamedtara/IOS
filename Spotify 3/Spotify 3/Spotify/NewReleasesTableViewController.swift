//
//  NewReleasesTableViewController.swift
//  Spotify
//
//  Created by user234266 on 11/27/23.
//

import UIKit

class NewReleasesTableViewController: UITableViewController {
    // This array will hold the new album releases data
    var newReleases: [Album] = []
    var spotifyService: SpotifyService?





    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Start the process to authenticate and then fetch new releases
        authenticateAndFetchReleases()
    }


    
    private func authenticateAndFetchReleases() {
        
        // Create an instance of the SpotifyAuthenticator
        let spotifyAuthenticator = SpotifyAuthenticator()

        // Get the access token
        spotifyAuthenticator.getAccessToken { [weak self] result in
            switch result {
            case .success(let accessToken):
                // If we get the token, we initialize the SpotifyService with the token
                self?.spotifyService = SpotifyService(accessToken: accessToken)
                // And then fetch new releases
                self?.fetchNewReleases()
            case .failure(let error):
                // If authentication fails, handle the error (e.g., show an alert)
                print("Authentication failed with error: \(error)")
            }
        }
    }
    func fetchNewReleases() {
        spotifyService?.fetchNewReleases { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let newReleasesResponse):
                    // Assuming newReleasesResponse.albums.items is the array of Album objects
                    self?.newReleases = newReleasesResponse.albums.items
                    self?.tableView.reloadData()
                case .failure(let error):
                    // Handle any errors, perhaps by showing an alert to the user
                    print(error.localizedDescription)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
           return min(newReleases.count, 7)

        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell of the custom type
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AlbumTableViewCell else {
            fatalError("Cell not configured in storyboard")
        }

        // Get the specific album for this row
        let album = newReleases[indexPath.row]

        // Set the labels in the custom cell
        cell.nameLabel.text = album.name
        //cell.typeLabel.text = album.album_type
        cell.releaseDateLabel.text = album.artists[0].name
        

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)  // Deselect the row for visual feedback

        // Get the selected album
        let selectedAlbum = newReleases[indexPath.row]
        
        // Assuming the first image in the images array is the one you want to display
       
        }
    }

    



