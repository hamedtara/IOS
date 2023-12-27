//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Hamed Tara on 2023-12-25.



import UIKit

struct CalculatorBrain{

    var bmi : BmiModel?
   // var advice: String?
    
    mutating  func calculate(height: Float, weight: Float) {
        let bmiValue  = weight / (height * height)
        
        if (bmiValue > 24.9){
            print("OverWeight")
            bmi = BmiModel(value: bmiValue, advice: "Stop Eating", color: UIColor.red)
        } else if (bmiValue < 18.5){
            print("UnderWeight")
            bmi = BmiModel(value: bmiValue, advice: "Eat More", color: UIColor.blue)
        } else {
            print("Normal Weight")
            bmi = BmiModel(value: bmiValue, advice: "You are fit", color: UIColor.green)
        }
    }

    
    func getBMI() -> String{
        let calculatedBMI = String(format: "%.2f", bmi?.value  ?? 0.0);
            return calculatedBMI;
    }
    
    func getAdvice() -> String{
        return bmi?.advice ?? "No Advice"
    }
    
    func getColor() -> UIColor{
        return bmi?.color ?? UIColor.white
    }

}
