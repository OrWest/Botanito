//
//  FormulViewController.swift
//  Botanito
//
//  Created by Alex Motor on 16.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

class FormulViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func backAction() {
        _ = navigationController?.popViewController(animated: true)
    }
}
