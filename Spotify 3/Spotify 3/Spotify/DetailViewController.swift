//
//  DetailViewController.swift
//  Spotify
//
//  Created by user234266 on 12/1/23.
//
import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var albumId: String = ""
    var spotifyService: SpotifyService?
    var authenticator: SpotifyAuthenticator?

    var albumDetails: AlbumResponse?  // To store the complete album data
    var tracks: [Track] = []


    @IBOutlet weak var tracksTableView: UITableView!
    @IBOutlet weak var imageViewer: UIImageView!

    override func viewDidLoad() {
            super.viewDidLoad()
            tracksTableView.dataSource = self
            authenticator = SpotifyAuthenticator()

            authenticator?.getAccessToken { [weak self] result in
                switch result {
                case .success(let accessToken):
                    self?.spotifyService = SpotifyService(accessToken: accessToken)
                    if !(self?.albumId.isEmpty)! {
                        self?.fetchAlbumDetails()
                    }
                case .failure(let error):
                    print("Error obtaining access token: \(error)")
                }
            }
        }

    func fetchAlbumDetails() {
        spotifyService?.fetchAlbum(albumId: albumId) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let albumResponse):
                    self?.albumDetails = albumResponse
                    self?.tracks = albumResponse.tracks.items
                    self?.updateUIWithAlbumDetails()
                    self?.tracksTableView.reloadData()
                case .failure(let error):
                    print("Error fetching album details: \(error)")
                }
            }
        }
    }
    
    func updateUIWithAlbumDetails() {
          
          if let albumImageUrl = albumDetails?.images.first?.url {
              fetchAndSetAlbumImage(from: albumImageUrl)
          }
      }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellDetails", for: indexPath)
        let track = tracks[indexPath.row]
        cell.textLabel?.text = track.name
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let trackDetailVC = segue.destination as? TrackDetailViewController,
           let indexPath = tracksTableView.indexPathForSelectedRow {
            let selectedTrack = tracks[indexPath.row]
            trackDetailVC.track = selectedTrack
        }
    }

    func fetchAndSetAlbumImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            return
        }
        print("Fetching album image from URL: \(urlString)")

        spotifyService?.fetchImageData(from: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        self?.imageViewer.image = image
                        print("Album image set successfully")
                    } else {
                        print("Failed to create image from data")
                    }
                case .failure(let error):
                    print("Error downloading image: \(error.localizedDescription)")
                }
            }
        }
    }
}
