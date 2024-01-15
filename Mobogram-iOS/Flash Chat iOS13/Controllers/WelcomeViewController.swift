//
//  WelcomeViewController.swift
//  Mobogram iOS
//
//  Created by Hamed Tara on 10/01/2024.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        
        titleLabel.text = K.appName
        
//        super.viewDidLoad()
//        var charIndex = 0.0;
//        let titleText = "😊Chatter"
//        titleLabel.text = ""
//        for letter in titleText {
//        Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
//            self.titleLabel.text?.append(letter);
//                }
//            charIndex += 1
//        }
        
        
    }
    

}
