//
//  MenuViewController.swift
//  Botanito
//
//  Created by Alex Motor on 16.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

class MenuViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backAction() {
        _ = navigationController?.popViewController(animated: true)
    }


}
