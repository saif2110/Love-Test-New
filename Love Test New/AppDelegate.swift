//
//  AppDelegate.swift
//  Love Test New
//
//  Created by Junaid Mukadam on 19/09/19.
//  Copyright © 2019 Saif Mukadam. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftySound

let Snd = Sound(url: Bundle.main.url(forResource: "bg", withExtension: "mp3")!)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       
        Snd?.play(numberOfLoops: 1000, completion: nil)
        IQKeyboardManager.shared.enable = true
        return true
    }
    
    
    
    
}

