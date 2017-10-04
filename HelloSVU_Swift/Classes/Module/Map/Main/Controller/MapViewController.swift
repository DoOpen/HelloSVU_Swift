//
//  MapViewController.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/5/23.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    var coordinate : CLLocationCoordinate2D?
    
    // MARK: - LazyLoad
    fileprivate lazy var mapView: MAMapView = {
        
        let mapView = MAMapView(frame: UIScreen.main.bounds)
        mapView.showsUserLocation = true
        mapView.pausesLocationUpdatesAutomatically = false
        mapView.allowsBackgroundLocationUpdates = true
        mapView.userTrackingMode = .followWithHeading
        mapView.compassOrigin = CGPoint(x: mapView.compassOrigin.x, y: 22)
        mapView.scaleOrigin = CGPoint(x: mapView.scaleOrigin.x, y: 22)
        mapView.delegate = self
        return mapView
    }()
    
    fileprivate lazy var toolView: MapToolView = {
        
        let toolView = MapToolView(CGRect(x: 0, y: ScreenH - 93, width: ScreenW, height: 44), ["线路站点","路线规划","一键返校"])
        return toolView
    }()
    
    fileprivate lazy var locationBtn: UIButton = {
        
        let locationBtn = UIButton(type: .custom)
        locationBtn.frame = CGRect(x: 8, y: toolView.y - 46 , w: 36, h: 36)
        locationBtn.setBackgroundColor(.white, forState: .normal)
        locationBtn.setImage(UIImage(named: "location"), for: .normal)
        locationBtn.addTarget(self, action: #selector(locateBtnDidClick), for: .touchUpInside)
        return locationBtn
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        toolViewClick()
    }
}

// MARK: - 设置 UI 界面
extension MapViewController {
    
    fileprivate func setUpUI() {
        
        navigationController?.delegate = self
        view.backgroundColor = .white
        view.addSubview(mapView)
        view.addSubview(toolView)
        view.addSubview(locationBtn)
    }
}

// MARK: - 点击事件
extension MapViewController {
    
    // MARK: - toolView 点击事件
    fileprivate func toolViewClick() {
        
        toolView.didClick = {[weak self] (selInex : Int) in
            
            switch selInex {
            case 0:
                print(selInex)
                break
            case 1:
                
                let vc = RoutePageViewController()
                self?.navigationController?.pushViewController(vc, animated: true)
                break
            case 2:
                print(selInex)
                break
            default:
                break
            }
        }
    }
    
    // MARK: - 定位按钮点击事件
    @objc fileprivate func locateBtnDidClick() {
        
        mapView.setZoomLevel(16.5, animated: true)
        if let coordinate = coordinate {
            mapView.setCenter(coordinate, animated: true)
        }
    }
}

// MARK: - MAMapViewDelegate
extension MapViewController : MAMapViewDelegate{
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        
        if updatingLocation == true {
            coordinate = userLocation.coordinate
        }
    }
    
    func mapInitComplete(_ mapView: MAMapView!) {
        locateBtnDidClick()
    }
}

// MARK: - UINavigationControllerDelegate
extension MapViewController : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        let isShowNav = viewController.isKind(of: MapViewController.self)
        navigationController.setNavigationBarHidden(isShowNav, animated: false)
        let disappearingVc = navigationController.viewControllers.last
        if let disappearingVc = disappearingVc {
            disappearingVc.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
}