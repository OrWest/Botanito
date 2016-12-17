//
//  FormulaQuestion.swift
//  Botanito
//
//  Created by Alex Motor on 17.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

class FormulaQuestion: NSObject {
    let text: String
    let answers: [UIImage]
    let correctAnswerIndex: Int
    
    required init(text: String, answers: [UIImage], correctIndex: Int) {
        self.text = text
        self.answers = answers
        self.correctAnswerIndex = correctIndex
        
        super.init()
    }
}
