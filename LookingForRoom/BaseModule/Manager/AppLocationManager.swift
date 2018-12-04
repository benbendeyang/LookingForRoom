//
//  AppLocationManager.swift
//  LookingForRoom
//
//  Created by 🐑 on 2018/12/3.
//  Copyright © 2018 Zhu. All rights reserved.
//
//  定位管理

import CoreLocation

class AppLocationManager: NSObject {
    
    static let NotificationChangeLocation = "NotificationChangeLocation"
    
    static let shared = AppLocationManager()
    
    /** 定位的当前国家 */
    private(set) var currentCountry: String? = "中国"
    
    /** 定位的当前省份 */
    private(set) var currentProvince: String? = "广州"
    
    /** 定位的当前城市 */
    private(set) var currentCity: String?
    
    /** 定位的当前城市所在的区(eg:普陀) */
    private(set) var currentArea: String?
    
    /** 定位的当前详细信息 */
    private(set) var currentAddress: String?
    
    /** 定位信息 */
    private(set) var currentLocation: CLLocation?
    
    /** 定位对象 */
    private var locationManager = CLLocationManager()

    private override init() {
        super.init()
        locationManager.delegate = self
        
        // 设置精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 设置间隔距离(单位：m) 内更新定位信息
        // 定位要求的精度越高，distanceFilter属性的值越小，应用程序的耗电量就越大。
        locationManager.distanceFilter = 1000.0
        
        // 权限检测
        locationPermissionsCheck()
    }
    
    //权限检测
    private func locationPermissionsCheck() {
        if CLLocationManager.locationServicesEnabled() == false {
            print("请确认已开启定位服务")
            return
        }
        // 请求用户授权
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            if #available(iOS 8.0, *) {
                locationManager.requestAlwaysAuthorization()
            }
        }
    }
    
    open func updatingLocation() {
        locationManager.startUpdatingLocation()
    }
}

// MARK: - 定位代理
extension AppLocationManager: CLLocationManagerDelegate {
    
    /// 定位成功
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //赋值
        currentLocation = locations.last
        guard let location = currentLocation else { return }
        // [S] 反编码以便获取其他信息
        let geoCoder: CLGeocoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { [weak self] (placemarks, error) in
            // 如果断网或者定位失败
            guard let `self` = self, let placemarks = placemarks else { return }
            let placeMark: CLPlacemark = placemarks[0]
            
            // 当前城市(把"市"过滤掉,否则 和 其他界面城市不匹配)
            self.currentCity = placeMark.locality?.replacingOccurrences(of: "市", with: "")
            // 详细地址
            self.currentAddress = placeMark.addressDictionary?["FormattedAddressLines"] as? String
            // 国家
            self.currentCountry = placeMark.addressDictionary?["Country"] as? String
            // 省份
            self.currentProvince = placeMark.addressDictionary?["State"] as? String
            // 区
            self.currentArea = placeMark.addressDictionary?["SubLocality"] as? String
            NotificationCenter.default.post(name: Notification.Name(rawValue: AppLocationManager.NotificationChangeLocation), object: nil)
        })
        locationManager.stopUpdatingLocation()
    }
    
    /// 定位失败
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位失败!详见：\(error)")
    }
}
