//
//  MenuViewController.swift
//  Botanito
//
//  Created by Alex Motor on 16.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

class FormulaMenuViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backAction() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? FormulaViewController else {
            print("Unknown vc")
            return
        }
        
        if segue.identifier == "Infinity" {
            vc.challengeType = .Infinity
        } else if segue.identifier == "Survival" {
            vc.challengeType = .Survival
        } else {
            print("\(#file):\(#function): unknown segue identifier")
        }
        
        let challenge = AppDelegate.shared.dataManager.prepareChallenge(challengeType: vc.challengeType)
        vc.challenge = challenge
    }

}
