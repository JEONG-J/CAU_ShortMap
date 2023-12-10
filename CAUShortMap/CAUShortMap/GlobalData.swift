//
//  GlobalData.swift
//  CAUShortMap
//
//  Created by 정의찬 on 12/10/23.
//

import Foundation
import CoreLocation

class GlobalData {
    static let shared = GlobalData()
    var wayPoint: [CLLocationCoordinate2D]?
    var modeflag: Int?
}
