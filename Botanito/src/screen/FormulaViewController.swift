//
//  FormulViewController.swift
//  Botanito
//
//  Created by Alex Motor on 16.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

class FormulaViewController: BaseViewController, UIGestureRecognizerDelegate {

    var challengeType: ChallengeType = .Survival
    var challenge: Challenge?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var tapView: UIView!
    
    private var currentQusetion: FormulaQuestion?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if challengeType == .Infinity {
            scoreLabel.isHidden = true
        } else {
            finishButton.isHidden = true
        }
        
        prepareNextQuestion()
        Analytics.StartChallenge(challenge: challenge!)
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
        
        if challenge!.answer(question: currentQusetion!, answerIndex: buttonIndex) {
            sender.backgroundColor = UIColor.green
        } else {
            let correctButton = answerButtons[currentQusetion!.correctAnswerIndex]
            correctButton.backgroundColor = UIColor.green
            sender.backgroundColor = UIColor.red
        }
        
        view.bringSubview(toFront: tapView)
    }
    
    @objc
    @IBAction func tapViewTapAction(_ sender: UITapGestureRecognizer) {
        prepareNextQuestion()
        view.sendSubview(toBack: tapView)
    }
    
    
    
    // MARK: - Private
    
    private func prepareNextQuestion() {
        scoreLabel.text = "\(challenge!.answeredCount)/\(challenge!.questionCount)"
        
        if let question = challenge!.nextQuestion() {
            questionLabel.text = question.text
            for i in 0...3 {
                let button = answerButtons[i]
                let answerImage = question.answers[i].resize(newWidth: button.bounds.width - 20)
                button.setImage(answerImage, for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0.9411764706, blue: 0.8196078431, alpha: 1)
            }
            
            print("CorrectAnwer = \(question.correctAnswerIndex) \(question.text): ")
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
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
