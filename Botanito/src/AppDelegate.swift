//
//  AppDelegate.swift
//  Botanito
//
//  Created by Alex Motor on 16.12.16.
//  Copyright © 2016 Alex Motor. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dataManager: DataManager!
    static let shared: AppDelegate = {
        return UIApplication.shared.delegate as! AppDelegate
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FIRApp.configure()
        dataManager = DataManager()
        Analytics.AppLaunched()
        
        return true
    }
}

