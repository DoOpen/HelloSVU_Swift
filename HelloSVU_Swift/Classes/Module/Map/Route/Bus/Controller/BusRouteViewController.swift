//
//  BusRouteViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/3.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

import DOPDropDownMenu_Enhanced

fileprivate let kMapsDropDownMenuH : CGFloat = 40

class BusRouteViewController: UIViewController {
    
    // MARK: - LazyLoad
    let strategy = ["最快捷" , "最经济" , "最少换乘" , "最少步行" , "最舒适" , "不乘地铁"]
    let time = ["现在出发"]
    
    lazy var menu: DOPDropDownMenu = {
        
        let menu = DOPDropDownMenu(origin: CGPoint(x: 0, y: 0), andHeight: kMapsDropDownMenuH)
        // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
        menu?.selectDefalutIndexPath()
        menu?.delegate = self
        menu?.dataSource = self
        return menu!
    }()
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: kMapsDropDownMenuH, w: ScreenW, h: view.frame.height - kMapsDropDownMenuH), style: .grouped)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, w: ScreenW, h: .leastNormalMagnitude))
        return tableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension BusRouteViewController {
    
    fileprivate func setUpUI() {
        
        view.backgroundColor = .white
        view.addSubview(menu)
    }
}

// MARK: - DOPDropDownMenuDataSource
extension BusRouteViewController : DOPDropDownMenuDataSource {

    func numberOfColumns(in menu: DOPDropDownMenu!) -> Int {
        return 2
    }

    func menu(_ menu: DOPDropDownMenu!, numberOfRowsInColumn column: Int) -> Int {
        return column == 0 ? strategy.count : time.count
    }
    
    func menu(_ menu: DOPDropDownMenu!, titleForRowAt indexPath: DOPIndexPath!) -> String! {
        return indexPath.column == 0 ? strategy[indexPath.row] : time[indexPath.row]
    }
}

// MARK: - DOPDropDownMenuDelegate
extension BusRouteViewController : DOPDropDownMenuDelegate {
    
    func menu(_ menu: DOPDropDownMenu!, didSelectRowAt indexPath: DOPIndexPath!) {
        
    }
}
