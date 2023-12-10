//
//  GraphViewModel.swift
//  CAUShortMap
//
//  Created by 정의찬 on 12/10/23.
//

import Foundation
import CoreLocation

class Graph {
    var edges: [Node: [Edge]] = [:]
    var info = GraphInfo()
    
    
    func addEdge(_ edge: Edge) {
        edges[edge.from, default: []].append(edge)
        
        if edge.flag != 2 {
            let reverseEdge = Edge(from: edge.to, to: edge.from, meters: edge.meters, time_needed: edge.time_needed, flag: edge.flag)
            edges[edge.to, default: []].append(reverseEdge)
        }
        
    }
    
    func dijkstra(graph: Graph, start: Node, end: Node) -> [Edge] {
        var distances = [Node: Int]()
        var previousEdges = [Node: Edge?]()
        var nodesToVisit = Set<Node>(graph.edges.keys) // priority queue를 set으로 교체
        
        // 거리와 edge 초기화
        for node in graph.edges.keys {
            distances[node] = node == start ? 0 : Int.max
            previousEdges[node] = nil
        }
        
        while !nodesToVisit.isEmpty {
            // 현재 노드 선택
            let currentNode = nodesToVisit.min { a, b in distances[a, default: Int.max] < distances[b, default: Int.max] }!
            nodesToVisit.remove(currentNode)
            
            // 목적지에 도달한 경우 경로 구성
            if currentNode == end {
                return constructPath(previousEdges, end)
            }
            
            // 인접 노드에 대한 거리 업데이트
            for edge in graph.edges[currentNode] ?? [] {
                if let currentNodeDistance = distances[currentNode], currentNodeDistance != Int.max {
                    let newDistance = currentNodeDistance + edge.time_needed
                    if newDistance < distances[edge.to, default: Int.max] {
                        distances[edge.to] = newDistance
                        previousEdges[edge.to] = edge
                    }
                }
            }
        }
        
        return [] // 찾을 수 없는 경우
    }
    
    func constructPath(_ previousEdges: [Node: Edge?], _ end: Node) -> [Edge] {
        var path = [Edge]()
        var currentNode = end

        // 경로 역추적
        while let edge = previousEdges[currentNode] as? Edge {
            path.insert(edge, at: 0)
            currentNode = edge.from
        }

        return path
    }
    
    
    func waitingTime(timetable: [String]) -> Int {
        var wait: Int = 0
        
        let now = Date()
        let calendar = Calendar.current
        let current_hour = calendar.component(.hour, from: now)
        let current_minute = calendar.component(.minute, from: now)
        
        
        var updated: Bool = false
        
        for time in timetable {
            wait = 0
            let bustime = time.components(separatedBy: ":")
            let bustime_hour = Int(bustime[0])!
            let bustime_minute = Int(bustime[1])!
            
            if current_hour < bustime_hour {
                wait += (bustime_hour - current_hour) * 60
                wait += bustime_minute - current_minute
                updated = true
                break
            } else if current_hour == bustime_hour {
                if current_minute <= bustime_minute {
                    wait += bustime_minute - current_minute
                    updated = true
                    break
                }
            }
        }
        
        if !updated {
            let bustime = timetable[0].components(separatedBy: ":")
            let bustime_hour = Int(bustime[0])!
            let bustime_minute = Int(bustime[1])!
            
            wait += (bustime_hour + 24 - current_hour) * 60
            wait += bustime_minute - current_minute
        }
        
        
        return wait
    }
    
    
    func setGraph(mode: Int) {
        
        reset()
        
        
        addEdge(info.sangdo_backgate)
        addEdge(info.backroad_backgate)
        addEdge(info.backroad_B305)
        addEdge(info.backroad_B303F6)
        addEdge(info.backroad_B310F1)
        
        addEdge(info.B310F1_B308)
        addEdge(info.B308_B208)
        addEdge(info.B308_B209)
        addEdge(info.B209_B208)
        addEdge(info.B208_B310F3)
        
        if mode != 1 {
            addEdge(info.haebang_B310F1)
            addEdge(info.haebang_B310F3)
            addEdge(info.haebang_B303F6)
            addEdge(info.haebang_B204_1)
        }
        addEdge(info.haebang_B310F5)
        addEdge(info.haebang_B303F1)
        addEdge(info.haebang_B204_0)
        
        addEdge(info.B204_B209)
        addEdge(info.B204_B106)
        addEdge(info.B204_B104F3)
        addEdge(info.B204_bluedragon)
        
        
        if mode != 1 {
            addEdge(info.bluedragon_haebang)
            addEdge(info.bluedragon_B303F1)
            addEdge(info.bluedragon_B303F6)
        }
        addEdge(info.B106_B104F3)
        addEdge(info.grass_B101)
        addEdge(info.grass_B102)
        addEdge(info.grass_B104F1)
        
        
        if mode != 1 {
            addEdge(info.grass_B104F3)
        }
        addEdge(info.grass_ppaegwang)
        addEdge(info.grass_frontgate)
        addEdge(info.heukseok_frontgate)
        addEdge(info.ppaegwang_bleudragon)
        
        
        if mode != 3 {
            addEdge(info.B310F1_B310F3)
            addEdge(info.B310F3_B310F5)
            addEdge(info.B303F6_B303F1)
            addEdge(info.B104F3_B104F1)
        }
        
        if mode == 0 {
            
            // 다음버스 기다리는 시간
            info.bluedragon_B204_bus.waiting = waitingTime(timetable: info.bluedragon_B204_table)
            info.B204_B209_bus.waiting = waitingTime(timetable: info.B204_B209_table)
            info.B209_B308_bus.waiting = waitingTime(timetable: info.B209_B308_table)
            info.B308_B310_bus.waiting = waitingTime(timetable: info.B308_B310_table)
            info.B310_backgate_bus.waiting = waitingTime(timetable: info.B310_backgate_table)
            info.backgate_sangdo_bus.waiting = waitingTime(timetable: info.backgate_sangdo_table)
            info.sangdo_backgate_bus.waiting = waitingTime(timetable: info.sangdo_backgate_table)
            info.backgate_B310_bus.waiting = waitingTime(timetable: info.backgate_B310_table)
            info.B310_B308_bus.waiting = waitingTime(timetable: info.B310_B308_table)
            info.B308_B209_bus.waiting = waitingTime(timetable: info.B308_B209_table)
            info.B209_B204_bus.waiting = waitingTime(timetable: info.B209_B204_table)
            info.B204_bluedragon_bus.waiting = waitingTime(timetable: info.B204_bluedragon_table)
            
            
            // 업데이트된 엣지 추가
            addEdge(info.B204_B209_bus)
            addEdge(info.B209_B308_bus)
            addEdge(info.B308_B310_bus)
            addEdge(info.B310_backgate_bus)
            addEdge(info.backgate_sangdo_bus)
            addEdge(info.sangdo_backgate_bus)
            addEdge(info.backgate_B310_bus)
            addEdge(info.B310_B308_bus)
            addEdge(info.B308_B209_bus)
            addEdge(info.B209_B204_bus)
            addEdge(info.B204_bluedragon_bus)
        }
    }
    
    
    
    func reset() {
        edges.removeAll()
    }
    
    
    func getNodes(point: String) -> Node {
        switch point {
        case "상도역":
            return info.sangdo
        case "후문":
            return info.backgate
        case "후문에서 310관 가는 길":
            return info.backroad
        case "305관":
            return info.B305
        case "303관 6층":
            return info.B303_6F
        case "303관 지하 1층":
            return info.B303_B1F
        case "310관 1층":
            return info.B310_1F
        case "310관 지하 3층":
            return info.B310_B3F
        case "310관 지하 5층":
            return info.B310_B5F
        case "308관 기숙사":
            return info.B308
        case "208관 공대":
            return info.B208
        case "209관 공대":
            return info.B209
        case "해방광장":
            return info.haebang
        case "204관 중도":
            return info.B204
        case "106관 의대":
            return info.B106
        case "청룡탕":
            return info.bluedragon
        case "104관 자과대 3층":
            return info.B104_3F
        case "104관 자과대 1층":
            return info.B104_1F
        case "101관 영신관":
            return info.B101
        case "빼빼로 광장":
            return info.ppaegwang
        case "영신관 앞 마당":
            return info.grass
        case "102관 약대":
            return info.B102
        case "정문":
            return info.frontgate
        case "흑석역":
            return info.heukseok
        default:
            return info.defaultNode
        }
    }
    //
    //    // Create an array to hold the CLLocationCoordinate2D
    //    var waypointCoordinates: [CLLocationCoordinate2D] = []
    //
    //    var graph = Graph()
    //    graph.set_graph(mode: 00)
    //
    //    let shortestPath = graph.dijkstra(graph: graph, start: graph.info.sangdo, end: graph.info.B310_1F)
    //
    //    // Calculate the total time needed and populate the waypointCoordinates array
    //    let totalTimeNeeded = shortestPath.reduce(0) { total, edge in
    //        print("\(edge.from.place) -> \(edge.to.place) (\(edge.meters) meters, \(edge.time_needed) minutes)")
    //
    //        // Create a CLLocationCoordinate2D from the 'from' node
    //        let fromCoordinate = CLLocationCoordinate2D(latitude: edge.from.latitude, longitude: edge.from.longitude)
    //        // Add the 'from' coordinate to the waypointCoordinates array
    //        waypointCoordinates.append(fromCoordinate)
    //
    //        // Additional prints for each edge
    //        print("\(edge.from.latitude)  \(edge.from.longitude)")
    //        if edge.flag == 1 {
    //            print("계단")
    //        } else if edge.flag == 2 {
    //            print("버스, 다음 버스까지 \(edge.waiting)분")
    //        } else if edge.flag == 3 {
    //            print("엘리베이터")
    //        } else {
    //            print("도보")
    //        }
    //
    //        return total + edge.time_needed
    //    }
    //
    //}
}
