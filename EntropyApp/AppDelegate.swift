//
//  AppDelegate.swift
//  EntropyApp
//
//  Created by Андрей Зорькин on 08/07/2019.
//  Copyright © 2019 Андрей Зорькин. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?

    private let rootAssembly: RootAssembly = RootAssembly()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let controller = rootAssembly.presentationAssembly.entropySourcesListViewController()
        if let window = window {
            window.rootViewController = rootAssembly.presentationAssembly.navigationController(rootViewController: controller)
            window.makeKeyAndVisible()
        } else {
            assertionFailure("[AppDelegate]: window is nil")
        }
        return true
    }

}

