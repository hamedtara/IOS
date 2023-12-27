//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Hamed Tara on 2023-12-25.

import UIKit

class calculateViewController: UIViewController {

    @IBOutlet weak var hightLabel: UILabel!
    //var calculatedBMI: String = "0.0"
    
    var calculateBrain = CalculatorBrain();

    
    @IBOutlet weak var weightLabel: UILabel!
    
    
    @IBOutlet weak var weightSlider: UISlider!
    
    @IBOutlet weak var hightSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func hightSelected(_ sender: UISlider) {
        let valueSelected = sender.value
               let heightFormatted = String(format: "%.2f m", valueSelected)
        
        hightLabel.text = heightFormatted;
               
           //    print("Height: \(heightFormatted)")
    }
    
    @IBAction func weightSelected(_ sender: UISlider) {
        let valueOfWeight = sender.value
                let weightFormatted = String(format: "%.0f Kg", valueOfWeight)
        
        
        weightLabel.text = weightFormatted;
              //  print("Weight: \(weightFormatted)")
        
    }
    
    @IBAction func WeightCalculator(_ sender: UIButton) {
        
        let height = hightSlider.value
            let weight  = weightSlider.value
            
        _ = weight / (height * height)
          //  calculatedBMI = String(format: "%.2f", bmiValue)
        
        calculateBrain.calculate(height: height,weight: weight)
            
            self.performSegue(withIdentifier: "toResult", sender: self)

        
        ///print (BMI);
        
        
     //   self.performSegue(withIdentifier: "toResult", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult" {
            let destinationVC = segue.destination as! resultViewController
            destinationVC.bmiValue = calculateBrain.getBMI();
            destinationVC.advice = calculateBrain.getAdvice();
            destinationVC.color = calculateBrain.getColor();
            
            
        }
    }


}

