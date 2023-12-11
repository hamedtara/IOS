//
//  AlbumTableViewCell.swift
//  Spotify
//
//  Created by user234266 on 11/28/23.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    //@IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
