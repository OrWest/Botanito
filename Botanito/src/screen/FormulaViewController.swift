//
//  FormulViewController.swift
//  Botanito
//
//  Created by Alex Motor on 16.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

class FormulaViewController: BaseViewController {

    var challengeType: ChallengeType = .Survival
    var challenge: Challenge?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    
    private var currentQusetion: FormulaQuestion?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if challengeType == .Infinity {
            scoreLabel.isHidden = true
        } else {
            finishButton.isHidden = true
        }
        
        prepareNextQuestion()
    }

    
    // MARK: - Action
    
    @IBAction func backAction() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func finishButtonAction(_ sender: Any) {
        finishChallenge()
    }
    
    
    @IBAction func answerButtonAction(_ sender: UIButton) {
        let buttonIndex = answerButtons.index(of: sender)!
        challenge!.answeredCount += 1
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        if buttonIndex == currentQusetion!.correctAnswerIndex {
            sender.backgroundColor = UIColor.green
            challenge!.correctAnswered += 1
        } else {
            let correctButton = answerButtons[currentQusetion!.correctAnswerIndex]
            correctButton.backgroundColor = UIColor.green
            sender.backgroundColor = UIColor.red
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1), execute: { [weak self] in
            UIApplication.shared.endIgnoringInteractionEvents()
            self?.prepareNextQuestion()
        })
    }
    
    
    // MARK: - Private
    
    private func prepareNextQuestion() {
        scoreLabel.text = "\(challenge!.correctAnswered)/\(challenge!.questionCount)"
        
        if let question = challenge!.nextQuestion() {
            questionLabel.text = question.text
            for i in 0...3 {
                let button = answerButtons[i]
                let answerImage = question.answers[i].resize(newWidth: button.bounds.width - 20)
                button.setImage(answerImage, for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.9411764706, blue: 0.8196078431, alpha: 1)
            }
            
            print("Question prepared. \(question.text): correctAnwer = \(question.correctAnswerIndex)")
            currentQusetion = question
        } else {
            finishChallenge()
        }
    }
    
    private func finishChallenge() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ResultController") as! ResultViewController
        vc.challenge = challenge
        navigationController!.pushViewController(vc, animated: true)
    }
    
}
