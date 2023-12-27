//
//  resultViewController.swift
//  BMI Calculator
//
//  Created by Hamed Tara on 2023-12-24.
//

import UIKit

class resultViewController: UIViewController {
    
    var bmiValue: String?
    var advice :String?
    var color :UIColor?

    @IBOutlet weak var bmilabel: UILabel!
    
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bmilabel.text = bmiValue;
        adviceLabel.text = advice;
        view.backgroundColor = color;
        
        // Do any additional setup after loading the view.
    }
    

    @IBAction func recalculateButton(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
