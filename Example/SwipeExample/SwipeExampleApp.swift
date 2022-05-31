//
//  SwipeExampleApp.swift
//  SwipeExample
//
//  Created by aromanov on 29.04.2022.
//

import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        self.window = window
        if #available(iOS 14.0, *) {
            window.rootViewController = UIHostingController(rootView: ExampleViewLazy())
        } else {
            window.rootViewController = UIHostingController(rootView: ExampleView())
        }
        window.makeKeyAndVisible()
        return true
    }
}


