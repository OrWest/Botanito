//
//  AnswerTableViewCell.swift
//  Botanito
//
//  Created by Alex Motor on 22.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    static let identifier = "AnswerCell"
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctImage: UIImageView!
    @IBOutlet weak var answeredImage: UIImageView!
    
    
    func configure(withAnswer answer: FormulaAnswer, number: Int) {
        numberLabel.text = "\(number). "
        questionLabel.text = answer.question.text
        correctImage.image = answer.question.answers[answer.question.correctAnswerIndex]
        answeredImage.image = answer.question.answers[answer.answeredIndex]
        answeredImage.backgroundColor = answer.answerCorrect ? UIColor.green : UIColor.red
        
    }

}
