//
//  MainViewController.swift
//  Spotify
//
//  Created by user234266 on 12/1/23.
//

import UIKit

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var newReleases: [Album] = []
    var spotifyService: SpotifyService?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
           return min(newReleases.count, 15)

        
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        // Get the specific album for this row
        let album = newReleases[indexPath.row]
        
        // Safely accessing the first artist's name if available
        let artistName = album.artists.first?.name ?? "Unknown Artist"

        // Set the cell's textLabel
        cell?.textLabel?.text = "\(album.name) - \(artistName)"
      //  cell?.textLabel?.text = "\(album.type)"

        return cell!
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dst = segue.destination as! DetailViewController
        dst.albumId = newReleases[tableView.indexPathForSelectedRow!.row].id
    }
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateAndFetchReleases()
        // Do any additional setup after loading the view.
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
    
    @IBOutlet weak var tableView: UITableView!
    func fetchNewReleases() {
        print("fetch")
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
}
