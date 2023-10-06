	//
//  ViewController.swift
//  Assignment1
//
//  Created by user234266 on 9/29/23.
//


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    var calculator = Calculator();

    override func viewDidLoad() {
        super.viewDidLoad();
    }

    @IBAction func clear(_ sender: Any) {
        calculator.clear();
        textView.text="";
        
    }

    @IBAction func numbers(_ sender: UIButton) {
        if let number = sender.titleLabel?.text {
            calculator.processButtonPress(input: number)
            textView.text = calculator.getEquation()
        }
    }

    @IBAction func operand(_ sender: UIButton) {
        if let oper = sender.titleLabel?.text {
            calculator.processButtonPress(input: oper)
            textView.text = calculator.getEquation()
        }
    }

    @IBAction func equal(_ sender: Any) {
        calculator.processButtonPress(input: "=")
        if let result = calculator.getResult() {
                        
           if !result.isNaN {
                textView.text = "\(result)"
            }
        } else {
            textView.text = "Error"
        }
    }


}
