//
//  AppDelegate.swift
//  NinetyNineVIPER
//
//  Created by Santi on 20/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAbsNet()
        setupWindow()
        return true
    }

    fileprivate func setupAbsNet() {
        let config = AbsNetConfiguration(url: "https://dev.ninetynine.com/testapi/1/")
        ApiService.with(configuration: config)
    }

    fileprivate func setupWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let nav = UINavigationController(rootViewController: CompanyListModule().provide())
        self.window?.rootViewController = nav
        
        self.window!.backgroundColor = UIColor.white
        self.window!.makeKeyAndVisible()
    }
}

