//
//  secondViewController.swift
//  BMI Calculator
//
//  Created by Hamed Tara on 2023-12-24.
//

import UIKit

class secondViewController: UIViewController {
    
    var bmiValue = "0.0";

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .red;
        
        
        let label = UILabel();
        
        label.text = bmiValue
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        view.addSubview(label);
    }
    

   

}
