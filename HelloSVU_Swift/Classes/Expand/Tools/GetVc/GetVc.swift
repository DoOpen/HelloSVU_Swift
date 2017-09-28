//
//  GetVc.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class GetVc: NSObject {
    
    class func getVcFromString(vcName : String) -> UIViewController {
        
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            
            print("没有获取到命名空间")
            return UIViewController.init()
        }
        guard let childVcClass = NSClassFromString(nameSpace + "." + vcName) else {
            
            print("没有获取到字符串对应的Class")
            return UIViewController.init()
        }
        guard let childVcType = childVcClass as? UIViewController.Type else {
            print("没有获取对应控制器的类型")
            return UIViewController.init()
        }
        
        return childVcType.init()
    }
}
