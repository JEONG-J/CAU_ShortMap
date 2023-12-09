//
//  ViewController.swift
//  CAUShortMap
//
//  Created by 정의찬 on 12/9/23.
//

import UIKit
import MapKit
import NMapsMap

class ViewController: UIViewController {
    
    private lazy var naverMapView = NMFNaverMapView(frame: self.view.frame)
    private lazy var mapView = NMFMapView()
    
    let data = LatLngDataModel()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        addMap()
        setMap()
        
    }
    
    //MARK: -Function
    
    private func addMap(){
        view.addSubview(naverMapView)
    }
    
    private func setMap(){
        naverMapOption()
        userInterface()
        naverMapCamera(model: data)
        userWhen()
    }
    
    private func naverMapOption(){
        mapView = naverMapView.mapView
        mapView.mapType = .basic
        mapView.isIndoorMapEnabled = true
        mapView.symbolScale = 1.2
    }
    
    private func naverMapCamera(model: LatLngDataModel){
        let lat = model.lat ?? 37.505102
        let lng = model.lng ?? 126.957105
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng), zoomTo: 15.0)
        cameraUpdate.animation = .easeIn
        mapView = naverMapView.mapView
        mapView.moveCamera(cameraUpdate)
    }
    
    private func userInterface(){
        naverMapView.showCompass = true
        naverMapView.showCompass = true
        naverMapView.showZoomControls = true
        naverMapView.showIndoorLevelPicker = true
        naverMapView.showLocationButton = true
    }
    
    private func userWhen(){
        mapView = naverMapView.mapView
        mapView.positionMode = .compass
    }
}

