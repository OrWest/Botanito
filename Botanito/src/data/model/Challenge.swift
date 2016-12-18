//
//  Challenge.swift
//  Botanito
//
//  Created by Alex Motor on 18.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

enum ChallengeType {
    case Survival
    case Infinity
}

class Challenge: NSObject {
    var correctAnswered = 0
    let questionCount: Int
    var correctAnsweredInPrecent: Float {
        get {
            return Float(correctAnswered) / Float(questionCount)
        }
    }
    var accepted: Bool {
        get {
            
            return correctAnsweredInPrecent > 0.8
        }
    }
    
    
    private let challengeType: ChallengeType
    private var questions: [FormulaQuestion]
    
    
    required init(families: [Family], challengeType: ChallengeType) {
        self.challengeType = challengeType
        questions = Challenge.prepareChallenge(families: families)
        questionCount = questions.count
        
        super.init()
    }
    
    // MARK: - Public
    
    func nextQuestion() -> FormulaQuestion? {
        let question = questions.first
        if question != nil {
            questions.remove(at: 0)
        }
    
        return question
    }
    
    
    // MARK: - Private
    
    static private func prepareChallenge(families: [Family]) -> [FormulaQuestion] {
        var questions: [FormulaQuestion] = []
        
        for family in families {
            var tempFamilies = families
            tempFamilies.remove(at: tempFamilies.index(of: family)!)
            
            let text = "Семейство \(family.name)"
            var answers: [UIImage] = []
            for _ in 0...2 {
                let randomInt = Int(arc4random_uniform(UInt32(tempFamilies.count)))
                let answerImage = tempFamilies[randomInt].image!
                answers.append(answerImage)
            }
            let correctAnswerIndex = Int(arc4random_uniform(4))
            answers.insert(family.image!, at: correctAnswerIndex)
            
            let question = FormulaQuestion(text: text, answers: answers, correctIndex: correctAnswerIndex)
            questions.append(question)
        }
        
        return questions
    }
    
}
