//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Hamed Tara on 2023-12-19.

//

import Foundation

struct Question {
    let text: String;
    let answer: String;
    
    init(q: String, a: String) {
        
        
        self.text = q;
        self.answer = a;
    }
}
