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
    var answeredCount = 0
    let questionCount: Int
    var answers: [FormulaAnswer]

    var correctAnsweredInPrecent: Float {
        get {
            return Float(correctAnswered) / Float(answeredCount)
        }
    }
    var accepted: Bool {
        get {
            
            return correctAnsweredInPrecent > 0.8
        }
    }
    
    
    private let challengeType: ChallengeType
    private var questions: [FormulaQuestion]
    private let families: [Family]
    
    
    required init(families: [Family], challengeType: ChallengeType) {
        self.challengeType = challengeType
        self.families = families
        if challengeType == .Survival {
            questions = Challenge.prepareChallenge(families: families)
        } else {
            questions = []
        }
        questionCount = questions.count
        answers = []
        
        super.init()
    }
    
    // MARK: - Public
    
    func nextQuestion() -> FormulaQuestion? {
        if challengeType == .Survival {
            return questions.first
        } else {
            return prepareRandomQuestion(families: families)
        }
    }
    
    func answer(question: FormulaQuestion, answerIndex: Int) -> Bool {
        answeredCount += 1
        
        var correct = false
        if question.correctAnswerIndex == answerIndex {
            correct = true
            correctAnswered += 1
        }
        if challengeType == .Survival {
            questions.remove(at: questions.index(of: question)!)
        }
        answers.append(FormulaAnswer(question: question, answeredIndex: answerIndex))
        
        return correct
    }
    
    
    // MARK: - Private
    
    static private func prepareChallenge(families: [Family]) -> [FormulaQuestion] {
        var questions: [FormulaQuestion] = []
        
        for family in families {
            var tempFamilies = families
            tempFamilies.remove(at: tempFamilies.index(of: family)!)
            
            if let types = family.types {
                for type in types {
                    var text = "Семейство \(family.name)"
                    if !type.isEmpty {
                        text.append(" \(type)")
                    }

                    var answers: [UIImage] = []
                    while answers.count < 3 {
                        let randomInt = Int(arc4random_uniform(UInt32(tempFamilies.count)))
                        guard let answerImage = tempFamilies[randomInt].image else { continue }
                        answers.append(answerImage)
                    }
                    let correctAnswerIndex = Int(arc4random_uniform(4))
                    answers.insert(family.typeImages![type]!, at: correctAnswerIndex)
                    
                    let question = FormulaQuestion(text: text, answers: answers, correctIndex: correctAnswerIndex)
                    questions.append(question)
                }
            } else {
                let text = "Семейство \(family.name)"
                var answers: [UIImage] = []
                while answers.count < 3 {
                    let randomFamilyInt = Int(arc4random_uniform(UInt32(tempFamilies.count)))
                    let randomFamily = tempFamilies[randomFamilyInt]
                    if let types = randomFamily.types {
                        let randomTypeInt = Int(arc4random_uniform(UInt32(types.count)))
                        let randomType = types[randomTypeInt]
                        guard let randomFormula = randomFamily.typeImages![randomType] else { continue }
                        answers.append(randomFormula)
                    } else {
                        guard let answerImage = randomFamily.image else { continue }
                        answers.append(answerImage)
                    }

                }
                let correctAnswerIndex = Int(arc4random_uniform(4))
                answers.insert(family.image!, at: correctAnswerIndex)
                
                let question = FormulaQuestion(text: text, answers: answers, correctIndex: correctAnswerIndex)
                questions.append(question)
            }
        }
        
        questions.shuffle()
        
        return questions
    }
    
    private func prepareRandomQuestion(families: [Family]) -> FormulaQuestion {
        let randomIndex = Int(arc4random_uniform(UInt32(families.count)))
        let randomFamily = families[randomIndex]
        
        var tempFamilies = families
        tempFamilies.remove(at: tempFamilies.index(of: randomFamily)!)
        
        if let types = randomFamily.types {
            let randomTypeIndex = Int(arc4random_uniform(UInt32(types.count)))
            let randomType = types[randomTypeIndex]
            var text = "Семейство \(randomFamily.name)"
            if !randomType.isEmpty {
                text.append(" \(randomType)")
            }
            var answers: [UIImage] = []
            while answers.count < 3 {
                let randomInt = Int(arc4random_uniform(UInt32(tempFamilies.count)))
                guard let answerImage = tempFamilies[randomInt].image else { continue }
                answers.append(answerImage)
            }
            let correctAnswerIndex = Int(arc4random_uniform(4))
            answers.insert(randomFamily.typeImages![randomType]!, at: correctAnswerIndex)
            
            return FormulaQuestion(text: text, answers: answers, correctIndex: correctAnswerIndex)
        } else {
            let text = "Семейство \(randomFamily.name)"
            var answers: [UIImage] = []
            while answers.count < 3 {
                let randomFamilyInt = Int(arc4random_uniform(UInt32(tempFamilies.count)))
                let randomFamily = tempFamilies[randomFamilyInt]
                if let types = randomFamily.types {
                    let randomTypeInt = Int(arc4random_uniform(UInt32(types.count)))
                    let randomType = types[randomTypeInt]
                    guard let randomFormula = randomFamily.typeImages![randomType] else { continue }
                    answers.append(randomFormula)
                } else {
                    guard let answerImage = randomFamily.image else { continue }
                    answers.append(answerImage)
                }
                
            }
            let correctAnswerIndex = Int(arc4random_uniform(4))
            answers.insert(randomFamily.image!, at: correctAnswerIndex)
            
            return FormulaQuestion(text: text, answers: answers, correctIndex: correctAnswerIndex)
        }
    }
    
}
