//
//  ResultViewController.swift
//  Botanito
//
//  Created by Alex Motor on 16.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var challenge: Challenge?
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var correctAnswerCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let correctAnsweredPercent = Int(challenge!.correctAnsweredInPrecent * 100)
        correctAnswerCountLabel.text = "\(correctAnsweredPercent) %"
        resultLabel.text = challenge!.accepted ? "ТЕСТ ПРОЙДЕН!" : "ТЕСТ ПРОВАЛЕН!"
    }
    

    @IBAction func finishAction() {
        _ = navigationController?.popToRootViewController(animated: true)
    }

}
