//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Hamed Tara on 11/09/2023.

//

import UIKit

class ViewController: UIViewController {

   
    
    @IBOutlet weak var diceImageView2: UIImageView!
    @IBOutlet weak var diceImageView1: UIImageView!
    
    let diceImages: [UIImage] = [
        UIImage(named: "DiceOne")!,
        UIImage(named: "DiceTwo")!,
        UIImage(named: "DiceThree")!,
        UIImage(named: "DiceFour")!,
        UIImage(named: "DiceFive")!,
        UIImage(named: "DiceSix")!
    ]

   
    
    var leftDice = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //change the dice to 6
        diceImageView1.image = UIImage(imageLiteralResourceName:"DiceSix")
     //   diceImageView1.alpha = 0.5;
        //change the dice to 2 
        diceImageView2.image=UIImage(imageLiteralResourceName: "DiceTwo")

    }

    @IBAction func roullButtonPressed(_ sender: UIButton) {
        
        let randomIndex1 = Int(arc4random_uniform(6))
           let randomIndex2 = Int(arc4random_uniform(6))

           // Update the dice images with a random dice
           diceImageView1.image = diceImages[randomIndex1]
           diceImageView2.image = diceImages[randomIndex2]
        
    }
    
}

