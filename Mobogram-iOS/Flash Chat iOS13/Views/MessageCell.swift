//
//  MessageCell.swift
//  Mobogram iOS
//
//  Created by Hamed Tara on 10/01/2024.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var MessageBubble: UIView!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var leftImageView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        MessageBubble.layer.cornerRadius = MessageBubble.frame.size.height / 5;
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
