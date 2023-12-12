//
//  ViewController.swift
//  CAUShortMap
//
//  Created by 정의찬 on 12/9/23.
//

import UIKit
import MapKit
import NMapsMap
import SnapKit
import CoreLocation
import FloatingPanel

class ViewController: UIViewController, UISearchBarDelegate, UISearchResultsUpdating, CLLocationManagerDelegate, MKMapViewDelegate,FloatingPanelControllerDelegate {
    
    public lazy var filteredResults = [BuildingName]()
    private lazy var graph = Graph()
    private lazy var locationManager = CLLocationManager()
    private lazy var sourceCoordinate = CLLocationCoordinate2D()
    private lazy var destCoordinate =  CLLocationCoordinate2D()
    private lazy var popUpView = MapInformation()
    private var modeFlag: Int?
    private lazy var pathOverlay =  NMFPolylineOverlay()
    private lazy var startText = ""
    private lazy var endText = ""
    private lazy var saveText = ""
    private let cauModel = CAUModel()
    private lazy var naverMapView = NMFNaverMapView(frame: self.view.frame)
    private lazy var mapView = NMFMapView()
    private lazy var searchMarker = NMFMarker()
    private lazy var sourceMarker = NMFMarker()
    private lazy var arriveMarker = NMFMarker()
    private lazy var sourceImage = NMFOverlayImage(name: "source.png")
    private lazy var arriveImage = NMFOverlayImage(name: "arrive.png")
    private lazy var searchImage = NMFOverlayImage(name: "vector.png")
    
    public lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: resultsTableController)
        controller.searchResultsUpdater = self
        controller.searchBar.delegate = self
        controller.searchResultsUpdater = self
        controller.searchBar.backgroundImage = UIImage() // 배경 제거
        controller.searchBar.barTintColor = UIColor.white // 원하는 색으로 변경
        controller.searchBar.searchTextField.backgroundColor = .white
        controller.searchBar.searchTextField.textColor = UIColor.black
        
        controller.searchBar.placeholder = "장소 검색"
        controller.searchBar.scopeButtonTitles = ["전부 포함", "엘레베이터 + 도보", "엘레베이터 + 도보 + 계단", "도보 + 계단"]
        controller.searchBar.scopeBarBackgroundImage = UIImage()
        controller.searchBar.showsCancelButton = false
        controller.hidesNavigationBarDuringPresentation = false
        
        controller.searchBar.layer.cornerRadius = 10
        controller.searchBar.layer.masksToBounds = true
        
        return controller
    }()
    
    
    private lazy var resultsTableController: UITableViewController = {
        let table = UITableViewController()
        table.tableView.delegate = self
        table.tableView.dataSource = self
        table.tableView.register(SearchViewCell.self, forCellReuseIdentifier: SearchViewCell.identifier)
        return table
    }()
    
    private lazy var sourceButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("출발지", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitleColor(UIColor(red: 0.42, green: 0.75, blue: 0.89, alpha: 1.00), for: .highlighted)
        btn.backgroundColor = UIColor(red: 0.42, green: 0.75, blue: 0.89, alpha: 1.00)
        btn.layer.cornerRadius = 30
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(startSource), for: .touchUpInside)
        return btn
    }()
    
    private lazy var arriveButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("도착지", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        btn.setTitleColor(UIColor(red: 0.42, green: 0.75, blue: 0.89, alpha: 1.00), for: .normal)
        btn.setTitleColor(.white, for: .highlighted)
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 30
        btn.layer.masksToBounds = true
        btn.addTarget(self, action: #selector(startDest), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
        addMap()
        setMap()
        makeConstraints()
    }
    
    //MARK: -Function
    
    private func addMap(){
        self.view.addSubview(naverMapView)
        self.view.addSubview(sourceButton)
        self.view.addSubview(arriveButton)
    }
    
    private func setSearchBar(){
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func makeConstraints(){
        arriveButton.snp.makeConstraints{ make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right).offset(-10)
            make.width.equalTo(250)
            make.height.equalTo(80)
        }
        
        sourceButton.snp.makeConstraints{ make in
            make.right.equalTo(arriveButton.snp.left).offset(-10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.width.equalTo(250)
            make.height.equalTo(80)
        }
        
    }
    
    private func sheetPop(){
        let apper = SurfaceAppearance()
        apper.cornerRadius = 25
        
        let fpc = FloatingPanelController()
        fpc.delegate = self
        fpc.surfaceView.appearance = apper
        fpc.layout = SetFloatingPanelLayout()
        
        let contenVC = popUpView
        
        fpc.set(contentViewController: contenVC)
        fpc.addPanel(toParent: self)
    }
    
    //MARK: -NaverMap
    
    private func setMap(){
        naverMapOption()
        userInterface()
        userWhen()
        //locatoinOverlay(model: data)
    }
    
    private func naverMapOption(){
        mapView = naverMapView.mapView
        mapView.mapType = .basic
        mapView.isIndoorMapEnabled = true
        mapView.symbolScale = 1.2
    }
    
    private func naverMapCamera(model: Node){
        let lat = model.lat ?? 37.505102
        let lng = model.lng ?? 126.957105
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat, lng: lng), zoomTo: 16.0)
        naverMapCameraMarker(model: model)
        cameraUpdate.animation = .easeIn
        mapView = naverMapView.mapView
        mapView.moveCamera(cameraUpdate)
    }
    
    private func naverMapCameraMarker(model: Node){
        let lat = model.lat ?? 37.505102
        let lng = model.lng ?? 126.957105
        searchMarker.iconImage = searchImage
        searchMarker.position = NMGLatLng(lat: lat, lng: lng)
        searchMarker.width = 45
        searchMarker.height = 55
        searchMarker.iconPerspectiveEnabled = true
        searchMarker.captionText = "\(model.name)"
        searchMarker.captionOffset = 10
        searchMarker.captionColor = UIColor.black
        searchMarker.captionTextSize = 13
        searchMarker.isHideCollidedSymbols = true
        searchMarker.isHideCollidedMarkers = true
        searchMarker.mapView = mapView
    }
    
    ///MARKER: - 기본 제공 인터페이스 활성화
    private func userInterface(){
        naverMapView.showCompass = true
        naverMapView.showIndoorLevelPicker = true
        naverMapView.showLocationButton = true
    }
    
    ///MARKER: - 사용자 현위치
    private func userWhen(){
        mapView = naverMapView.mapView
        mapView.positionMode = .compass
    }
    
    ///MARKER: - 출발 지점 마커
    private func sourceMarkerMake(model: Node){
        mapView = naverMapView.mapView
        
        searchMarker.mapView = nil
        sourceMarker.iconImage = sourceImage
        sourceMarker.position = NMGLatLng(lat: model.lat ?? 37.505102, lng: model.lng ?? 126.957105)
        sourceMarker.width = 45
        sourceMarker.height = 55
        sourceMarker.iconPerspectiveEnabled = true
        sourceMarker.captionText = "출발 푸앙!"
        sourceMarker.captionOffset = 10
        sourceMarker.captionColor = UIColor.blue
        sourceMarker.captionTextSize = 13
        sourceMarker.isHideCollidedSymbols = true
        
        sourceMarker.mapView = mapView
    }
    
    ///MARKER: - 출발 지점 마커
    private func arriveMakerMake(model: Node){
        mapView = naverMapView.mapView
        
        searchMarker.mapView = nil
        arriveMarker.iconImage = arriveImage
        arriveMarker.position = NMGLatLng(lat: model.lat ?? 37.505102, lng: model.lng ?? 126.957105)
        arriveMarker.width = 45
        arriveMarker.height = 55
        arriveMarker.iconPerspectiveEnabled = true
        arriveMarker.captionText = "도착 푸앙!"
        arriveMarker.captionOffset = 10
        arriveMarker.captionColor = UIColor.red
        arriveMarker.captionTextSize = 13
        arriveMarker.isHideCollidedSymbols = true
        
        arriveMarker.mapView = mapView
    }
    
    private func locatoinOverlay(model: Node) {
        mapView = naverMapView.mapView
        let locationOverlay = mapView.locationOverlay
        locationOverlay.location = NMGLatLng(lat: model.lat ?? 37.505102, lng: model.lng ?? 126.957105)
        locationOverlay.icon = NMFOverlayImage(name: "location_overlay_icon")
        locationOverlay.iconWidth = 30
        locationOverlay.iconHeight = 30
        locationOverlay.circleRadius = 20
    }
    
    private func calCul(){
        graph.setGraph(mode: self.modeFlag ?? 0)
        print(graph.setGraph(mode: self.modeFlag ?? 0))
        
        
        let startModel = graph.getNodes(point: startText)
        let endModel = graph.getNodes(point: endText)
        
        let shortestPath = graph.dijkstra(graph: graph, start: startModel, end: endModel)
        print(shortestPath)
        var waypointCoordinates: [CLLocationCoordinate2D] = []
        var pathDescription: [String] = []
        
        shortestPath.enumerated().forEach { index, edge in
            
            if edge.flag == 1 {
                let edgeDescription = "\(edge.from.name) -> \(edge.to.name) (\(edge.meters) meters, \(edge.time_needed) minutes) -> 계단이용 \n"
                pathDescription.append(edgeDescription)
            } else if edge.flag == 2 {
                let edgeDescription = "\(edge.from.name) -> \(edge.to.name) (\(edge.meters) meters,  \(edge.time_needed) minutes) -> 버스, 다음 버스까지 \(edge.waiting)분 \n"
                pathDescription.append(edgeDescription)
            } else if edge.flag == 3 {
                let edgeDescription = "\(edge.from.name) -> \(edge.to.name) (\(edge.meters) meters, \(edge.time_needed) minutes) -> 엘레베이터 이용 \n"
                pathDescription.append(edgeDescription)
            } else {
                let edgeDescription = "\(edge.from.name) -> \(edge.to.name) (\(edge.meters) meters, \(edge.time_needed) minutes) -> 도보 이용 \n"
                pathDescription.append(edgeDescription)
            }
            
            print("\(edge.from.name) -> \(edge.to.name) (\(edge.meters) meters, \(edge.time_needed) minutes)")

            if index != 0 {
                let fromCoordinate = CLLocationCoordinate2D(latitude: edge.from.lat ?? 0, longitude: edge.from.lng ?? 0)
                waypointCoordinates.append(fromCoordinate)
            }

            print("\(edge.from.lat ?? 0)  \(edge.from.lng ?? 0)")
        }
        
        mapPathSetup(naverMapView, waypointCoordinates: waypointCoordinates)
        let combinedPathDescription = pathDescription.joined(separator: "\n")
        popUpView.pathInformation = combinedPathDescription

        // 총 시간 계산
        let totalTimeNeeded = shortestPath.reduce(0) { total, edge in
            return total + edge.time_needed
        }
    }
    
    private func mapPathSetup(_ mapView: NMFNaverMapView, waypointCoordinates: [CLLocationCoordinate2D]) {
        // 첫 번째 세그먼트 계산 시작
        calculateNextSegment(mapView: mapView, waypointCoordinates: waypointCoordinates, index: 0, naverCoordinates: []) { finalCoordinates in
            DispatchQueue.main.async {
                if let overlay = NMFPolylineOverlay(NMGLineString(points: finalCoordinates)) {
                    overlay.width = 5
                    overlay.mapView = mapView.mapView
                    overlay.color = .purple
                    self.pathOverlay = overlay
                }
                
            }
        }
    }

    private func calculateNextSegment(mapView: NMFNaverMapView, waypointCoordinates: [CLLocationCoordinate2D], index: Int, naverCoordinates: [NMGLatLng], completion: @escaping ([NMGLatLng]) -> Void) {
        if index < waypointCoordinates.count {
            let startCoord = index == 0 ? sourceCoordinate : waypointCoordinates[index - 1]
            let endCoord = waypointCoordinates[index]

            calculatePathSegment(startCoord: startCoord, endCoord: endCoord) { newCoordinates in
                let updatedCoordinates = naverCoordinates + newCoordinates
                if index == waypointCoordinates.count - 1 {
                    completion(updatedCoordinates)
                } else {
                    self.calculateNextSegment(mapView: mapView, waypointCoordinates: waypointCoordinates, index: index + 1, naverCoordinates: updatedCoordinates, completion: completion)
                }
            }
        } else {
            completion(naverCoordinates)
        }
    }

    private func calculatePathSegment(startCoord: CLLocationCoordinate2D, endCoord: CLLocationCoordinate2D, completion: @escaping ([NMGLatLng]) -> Void) {
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: MKPlacemark(coordinate: startCoord))
        directionRequest.destination = MKMapItem(placemark: MKPlacemark(coordinate: endCoord))
        directionRequest.requestsAlternateRoutes = true
        directionRequest.transportType = .walking

        let directions = MKDirections(request: directionRequest)
        directions.calculate { response, error in
            guard let response = response, let route = response.routes.first else {
                if let error = error {
                    print("Error calculating directions: \(error)")
                }
                completion([])
                return
            }
            
            let coordinates = route.polyline.coordinates
            let naverCoordinates = coordinates.map { NMGLatLng(lat: $0.latitude, lng: $0.longitude) }
            completion(naverCoordinates)
        }
    }
    
    private func initMap(){
        self.pathOverlay.mapView = nil
        arriveMarker.mapView = nil
    }
    
    //MARK: - SearchBarEvent
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        
        if let model = cauModel.getLocationData(for: searchText) {
            saveText = searchText
            naverMapCamera(model: model)
        } else {
            print("해당 위치 없음")
        }
        
        searchController.isActive = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        filteredResults = CAUModel.buildingName
        resultsTableController.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            filteredResults = CAUModel.buildingName.filter { building in
                building.name.lowercased().contains(searchText.lowercased())
            }
        } else {
            filteredResults = CAUModel.buildingName
        }
        resultsTableController.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        self.modeFlag = selectedScope
        print("\(selectedScope) 선택됨")
        print("값 : \(modeFlag ?? 0)")
    }
    
    //MARK: - Objc
    @objc func startSource(){
        if let model = cauModel.getLocationData(for: saveText){
            initMap()
            startText = saveText
            print(startText)
            sourceMarkerMake(model: model)
            sourceCoordinate = CLLocationCoordinate2D(latitude: model.lat ?? 37.505102, longitude: model.lng ?? 126.957105)
            print("생성 완료")
        } else {
            print ("다시 검색하세요")
        }
    }
    
    @objc func startDest(){
        if let model = cauModel.getLocationData(for: saveText){
            arriveMakerMake(model: model)
            endText = saveText
            print(endText)
            destCoordinate = CLLocationCoordinate2D(latitude: model.lat ?? 37.505102, longitude: model.lng ?? 126.957105)
            calCul()
            sheetPop()
        } else {
            print("다시 검색하세요")
        }
    }
}

class SetFloatingPanelLayout: FloatingPanelLayout{
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .half
    let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] = [
        .full: FloatingPanelLayoutAnchor(absoluteInset: 0.5, edge: .top, referenceGuide: .safeArea),
        .half: FloatingPanelLayoutAnchor(fractionalInset: 0.5, edge: .bottom, referenceGuide: .safeArea),
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 50, edge: .bottom, referenceGuide: .safeArea),
        .hidden: FloatingPanelLayoutAnchor(absoluteInset: 0, edge: .bottom, referenceGuide: .safeArea)
    ]
    
}

extension MKPolyline {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: CLLocationCoordinate2D(), count: pointCount)
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        return coords
    }
}

