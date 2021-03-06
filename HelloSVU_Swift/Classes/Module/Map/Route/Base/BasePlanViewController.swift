//
//  BasePlanViewController.swift
//  HelloSVU_Swift
//
//  Created by a on 2017/11/30.
//Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

/// 路径规划的类型
///
/// - Riding: 骑车
/// - Walking: 步行
/// - Driving: 驾车
enum routePlanType {
    
    case Riding
    case Walking
    case Driving
}

class BasePlanViewController: BaseViewController {
    
    @IBOutlet private weak var mapContentView: UIView!
    @IBOutlet private weak var durationLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var bottomViewH: NSLayoutConstraint!
    @IBOutlet private weak var collectionContentViewH: NSLayoutConstraint!
    @IBOutlet private weak var btnTopMargin: NSLayoutConstraint!
    
    public var routePlanType: routePlanType = .Riding
    
    // MARK: - LazyLoad
    private lazy var search: AMapSearchAPI = {
        
        let search = AMapSearchAPI()
        search?.delegate = self
        return search!
    }()
    /// 骑车
    private lazy var ridingRouteRequest = AMapRidingRouteSearchRequest()
    /// 步行
    private lazy var walkRouteRequest = AMapWalkingRouteSearchRequest()
    /// 驾车
    private lazy var drivingRouteRequest: AMapDrivingRouteSearchRequest = {
        
        let drivingRouteRequest = AMapDrivingRouteSearchRequest()
        drivingRouteRequest.requireExtension = true
        return drivingRouteRequest
    }()
    
    /// 地图
    private lazy var mapView: MAMapView = {
        
        let mapView = MAMapView(frame: mapContentView.bounds)
        mapView.showsUserLocation = true
        // 追踪用户的location与heading更新
        mapView.userTrackingMode = MAUserTrackingMode.followWithHeading
        mapView.pausesLocationUpdatesAutomatically = false
        mapView.allowsBackgroundLocationUpdates = true//iOS9以上系统必须配置
        mapView.compassOrigin = CGPoint(x: mapView.compassOrigin.x, y: 22)
        mapView.scaleOrigin = CGPoint(x: mapView.compassOrigin.x, y: 22)
        mapView.delegate = self
        return mapView
    }()
    
    /// 定位按钮
    private lazy var locationBtn: UIButton = {
        
        let locationBtn = UIButton(type: .custom)
        locationBtn.backgroundColor = .white
        locationBtn.setImage(#imageLiteral(resourceName: "location"), for: .normal)
        locationBtn.frame = CGRect(x: 10, y: mapContentView.bottom - 46, width: 36, height: 36)
        locationBtn.addTarget(self, action: #selector(locatateNow), for: .touchUpInside)
        return locationBtn
    }()
    
    /// 定位到的经纬度
    private var nowCoordinate: CLLocationCoordinate2D?
    /// 路径规划方案
    private var route: AMapRoute?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
}

// MARK: - 设置 UI 界面
extension BasePlanViewController {
    
    private func setUpUI() {
        
        mapContentView.addSubview(mapView)
        cheekIsDriveView()
    }
    
    // MARK: - 驾车界面时改变底部View显示
    private func cheekIsDriveView() {
        
        guard routePlanType == .Driving else {
            return
        }
        
        let priority = UILayoutPriority(rawValue: 100)
        bottomViewH.priority = priority
        btnTopMargin.priority = priority
        collectionContentViewH.priority = priority
    }
}

// MARK: - MAMapViewDelegate
extension BasePlanViewController: MAMapViewDelegate {
    
    func mapView(_ mapView: MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation: Bool) {
        
        if updatingLocation == true {
            
            nowCoordinate = userLocation.coordinate
            mapView.addSubview(locationBtn)
        }
    }
}

// MARK: - AMapSearchDelegate
extension BasePlanViewController: AMapSearchDelegate {
    
    func aMapSearchRequest(_ request: Any!, didFailWithError error: Error!) {
        SVUHUD.dismiss()
    }
    
    func onRouteSearchDone(_ request: AMapRouteSearchBaseRequest!, response: AMapRouteSearchResponse!) {
        
        SVUHUD.dismiss()
        route = response.route
        if routePlanType == .Driving {
            
        }else {
            
            durationLabel.text =  CalculateTool.getDuration(route?.paths[0].duration ?? 0)
            distanceLabel.text =  CalculateTool.getWalkDistance(CGFloat(route?.paths.first?.distance ?? 0))
        }
    }
}

// MARK: - 事件处理
extension BasePlanViewController {

    // MARK: - 定位按钮点击
    @objc private func locatateNow() {
        
        mapView.setZoomLevel(16.5, animated: true)
        if let nowCoordinate = nowCoordinate {
            mapView.setCenter(nowCoordinate, animated: true)
        }
    }
    
    // MARK: - 开始导航点击
    @IBAction private func startNavBtnDidClick(_ sender: Any) {
        print("点击了开始导航")
    }
}
