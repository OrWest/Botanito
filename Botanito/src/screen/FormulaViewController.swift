//
//  FormulViewController.swift
//  Botanito
//
//  Created by Alex Motor on 16.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

enum ChallengeType {
    case Survival
    case Infinity
}

class FormulaViewController: BaseViewController {

    var challengeType: ChallengeType = .Survival
    var challenge: [FormulaQuestion]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backAction() {
        _ = navigationController?.popViewController(animated: true)
    }
}
