//
//  LaunchViewController.swift
//  Botanito
//
//  Created by Alex Motor on 17.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit

class LaunchViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        AppDelegate.shared.dataManager.fillDataBase { [weak self] in
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "MainNavigationController")
            UIApplication.shared.delegate!.window!?.rootViewController = vc
        }
    }

}
