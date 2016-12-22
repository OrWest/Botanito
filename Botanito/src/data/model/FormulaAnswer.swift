//
//  FormulaAnswer.swift
//  Botanito
//
//  Created by Alex Motor on 22.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

class FormulaAnswer: NSObject {
    let question: FormulaQuestion
    let answeredIndex: Int
    var answerCorrect: Bool {
        get {
            return question.correctAnswerIndex == answeredIndex
        }
    }
    
    required init(question: FormulaQuestion, answeredIndex: Int) {
        self.question = question
        self.answeredIndex = answeredIndex
        super.init()
    }
}
