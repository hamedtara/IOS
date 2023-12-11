//
//  TrackDetailViewController.swift
//  Spotify
//
//  Created by user234266 on 12/7/23.
//

import UIKit

class TrackDetailViewController: UIViewController {
    var track: Track?
    
    @IBOutlet weak var TrackName: UILabel!
    
    @IBOutlet weak var Duration: UILabel!
    
    
    @IBOutlet weak var TrackNumber: UILabel!
    
    @IBOutlet weak var Artists: UILabel!
    
    @IBOutlet weak var albumImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let track = track {
            TrackName.text = "TrackName:\(track.name)"
            TrackNumber.text = "Track Number: \(track.track_number)"
            
            let durationInSeconds = track.duration_ms / 1000
            let minutes = durationInSeconds / 60
            let seconds = durationInSeconds % 60
            Duration.text = String(format: "%d:%02d", minutes, seconds)
            
            let artistNames = track.artists.map { $0.name }.joined(separator: ", ")
            Artists.text = "Artist(s):\(artistNames)"

            } else {
                print("No image URL found for the album")
            }
        }
    }
 
