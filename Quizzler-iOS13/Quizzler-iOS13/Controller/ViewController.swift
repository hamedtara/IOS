//
//  ViewController.swift
//  Created by Hamed Tara on 2023-12-20.
//

import UIKit

class ViewController: UIViewController {
    var quizeBrain = QuizBrain();
   
    
    
    var timer: Timer?


    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }


    @IBAction func answerButtonClicked(_ sender: UIButton) {
        let selectedAnswerByUser = sender.currentTitle!;
      let givenAnswer  =  quizeBrain.checkAnswer(selectedAnswerByUser);
        
        updateUI();
                
        if givenAnswer {
            sender.backgroundColor = UIColor.green;
                
        }else {
           sender.backgroundColor = UIColor.red;
            
        }
       
        quizeBrain.nextQuestion();
        
        
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)

    }
    
    @objc func updateUI(){
        
        questionLabel.text = quizeBrain.getQuestionText();
        
       // let totalQuestion = quizQuestions.count ;
      //  let progress = Float(questionNumber+1)/Float(totalQuestion)
        
        trueButton.backgroundColor = UIColor.clear;
        falseButton.backgroundColor = UIColor.clear
        scoreLable.text = "Score : \(quizeBrain.getScore())"
        
        progressBar.progress = quizeBrain.getProcess();
    }
    
}

