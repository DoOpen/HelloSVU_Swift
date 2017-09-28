//
//  TabBarController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seUpTabBarAttr()
        guard let jsonPath = Bundle.main.path(forResource: "MainVCSettings.json", ofType: nil) else {
            
            print("没有获取到对应的文件路径")
            return
        }
        
        guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) else {
            print("没有获取到json文件中数据")
            return
        }
        
        guard let anyObject = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) else {
            return
        }
        
        guard let dictArray = anyObject as? [[String : AnyObject]] else {
            return
        }
        
        for dict in dictArray {
            
            guard let vcName = dict["vcName"] as? String else {continue}
            guard let title = dict["title"] as? String else {continue}
            guard let normalImg = dict["normalImg"] as? String else {continue}
            guard let selImg = dict["selImg"] as? String else {continue}
            
            addChildVc(childVcName: vcName, title: title, normalImg: normalImg, selImg: selImg)
        }
    }
}

// MARK: - 设置 TabBar 属性
extension TabBarController {
    
    fileprivate func seUpTabBarAttr() {
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.darkGray], for: .selected)
    }
}

// MARK: - 设置子控制器
extension TabBarController {
    
    fileprivate func addChildVc(childVcName : String, title : String, normalImg : String, selImg : String) {
        
        let childVc = GetVc.getVcFromString(vcName: childVcName)
        
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: normalImg)
        childVc.tabBarItem.selectedImage = UIImage(named: selImg)
        
        let childNav = NavigationController(rootViewController: childVc)
        
        addChildViewController(childNav)
    }
}
