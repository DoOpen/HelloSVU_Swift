//
//  AppDelegate.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/7.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static let tabBarContoller = TabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setUpRootViewController()
        setUpAmapKey()
        fitiOSEleven()
        return true
    }
}

// MARK: - 基础设置
extension AppDelegate {
    
    // MARK: - 设置根控制器
    private func setUpRootViewController() {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = AppDelegate.tabBarContoller
        window?.makeKeyAndVisible()
    }
    
    // MARK: - 设置高德地图 Key
    private func setUpAmapKey() {
        
        AMapServices.shared().apiKey = "d9aa67c1ca9645f044bc2842e5fa1464"
        AMapServices.shared().enableHTTPS = true
    }
    
    // MARK: - 适配 iOS 11
    private func fitiOSEleven() {
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        }
    }
}
