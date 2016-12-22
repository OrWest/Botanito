//
//  ResultViewController.swift
//  Botanito
//
//  Created by Alex Motor on 16.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController, UITableViewDataSource {

    var challenge: Challenge?
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var correctAnswerCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let correctAnsweredPercent = Int(challenge!.correctAnsweredInPrecent * 100)
        correctAnswerCountLabel.text = "\(correctAnsweredPercent) %"
        resultLabel.text = challenge!.accepted ? "ТЕСТ ПРОЙДЕН!" : "ТЕСТ ПРОВАЛЕН!"
        
        Analytics.EndChallenge(challenge: challenge!)
    }
    

    @IBAction func finishAction() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return challenge!.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnswerTableViewCell.identifier) as! AnswerTableViewCell
        let answer = challenge!.answers[indexPath.row]
        cell.configure(withAnswer: answer, number: indexPath.row + 1)
        
        return cell
    }

}
