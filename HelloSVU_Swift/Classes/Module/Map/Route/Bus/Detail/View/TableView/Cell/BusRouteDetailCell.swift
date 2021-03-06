//
//  BusRouteDetailCell.swift
//  HelloSVU_Swift
//
//  Created by Insect on 2017/10/16.
//  Copyright © 2017年 Insect. All rights reserved.
//

import UIKit

class BusRouteDetailCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var viaStopLabel: UILabel!

    var busStop: AMapBusStop? {
        
        didSet {
            viaStopLabel.text = busStop?.name
        }
    }
}
