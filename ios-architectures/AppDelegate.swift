//
//  AppDelegate.swift
//  ios-architectures
//
//  Created by 田中 達也 on 2016/11/27.
//  Copyright © 2016年 tattn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let app = EntryPoint()
        let vc = app.main()
        let nc = UINavigationController(rootViewController: vc)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()

        return true
    }
}

