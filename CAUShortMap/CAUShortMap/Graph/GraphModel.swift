//
//  GraphModel.swift
//  CAUShortMap
//
//  Created by 정의찬 on 12/10/23.
//

import Foundation


public struct Edge {
    let from: Node
    let to: Node
    let meters: Int
    var time_needed: Int
    var waiting: Int = 0

    // flag: 0 -> 도보, 1 -> 계단, 2 -> 버스, 3 -> 엘리베이터
    let flag: Int
}

// 노드
class GraphInfo {
    let sangdo: Node
    let backgate: Node
    let backroad: Node
    let B305: Node

    // 이름바뀜
    let B303_6F: Node
    let B303_B1F: Node
    let B310_1F: Node
    let B310_B3F: Node
    let B310_B5F: Node
    
    let B308: Node
    let B208: Node
    let B209: Node
    let haebang: Node
    let bluedragon: Node
    let B204: Node

    //이름바뀜
    let B104_3F: Node
    let B104_1F: Node
    
    let B106: Node
    let ppaegwang: Node

    let grass: Node
    let B101: Node
    let B102: Node
    let frontgate: Node
    let heukseok: Node
    
    let defaultNode: Node


    let sangdo_backgate: Edge
    let backroad_backgate: Edge
    let backroad_B305: Edge
    let backroad_B303F6: Edge
    let backroad_B310F1: Edge

    let B310F1_B308: Edge
    let B308_B208: Edge
    let B308_B209: Edge
    let B209_B208: Edge
    let B208_B310F3: Edge

    let haebang_B310F1: Edge
    let haebang_B310F3: Edge
    let haebang_B310F5: Edge
    let haebang_B303F6: Edge
    let haebang_B303F1: Edge
    let haebang_B204_1: Edge
    let haebang_B204_0: Edge

    let B204_B209: Edge
    let B204_B106: Edge
    let B204_B104F3: Edge
    let B204_bluedragon: Edge

    let bluedragon_haebang: Edge
    let bluedragon_B303F1: Edge
    let bluedragon_B303F6: Edge

    let B106_B104F3: Edge
    let grass_B101: Edge
    let grass_B102: Edge
    let grass_B104F1: Edge
    let grass_B104F3: Edge
    let grass_ppaegwang: Edge
    let grass_frontgate: Edge
    let heukseok_frontgate: Edge
    let ppaegwang_bleudragon: Edge

    // 엘리베이터
    let B310F1_B310F3: Edge
    let B310F3_B310F5: Edge
    let B303F6_B303F1: Edge
    let B104F3_B104F1: Edge

    // 버스
    var bluedragon_B204_bus: Edge
    var B204_B209_bus: Edge
    var B209_B308_bus: Edge
    var B308_B310_bus: Edge
    var B310_backgate_bus: Edge
    var backgate_sangdo_bus: Edge
    var sangdo_backgate_bus: Edge
    var backgate_B310_bus: Edge
    var B310_B308_bus: Edge
    var B308_B209_bus: Edge
    var B209_B204_bus: Edge
    var B204_bluedragon_bus: Edge
    
    


    // 버스시간표
    let bluedragon_B204_table = ["08:00", "08:10", "08:20", "08:30", "08:40", "08:50", "09:00", "09:10", "09:20", "09:30", "09:40", "09:50", "10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45", "13:00", "13:15", "13:30", "13:45", "14:00", "14:15", "14:30", "14:45", "15:00", "15:15", "15:30", "15:45", "16:00", "16:10", "16:20", "16:30", "16:40", "16:50", "17:00", "17:10", "17:20", "17:30", "17:40", "17:50", "18:00", "18:10", "18:20", "18:30"]
    let B204_B209_table = ["08:01", "08:11", "08:21", "08:31", "08:41", "08:51", "09:01", "09:11", "09:21", "09:31", "09:41", "09:51", "10:01", "10:16", "10:31", "10:46", "11:01", "11:16", "11:31", "11:46", "12:01", "12:16", "12:31", "12:46", "13:01", "13:16", "13:31", "13:46", "14:01", "14:16", "14:31", "14:46", "15:01", "15:16", "15:31", "15:46", "16:01", "16:11", "16:21", "16:31", "16:41", "16:51", "17:01", "17:11", "17:21", "17:31", "17:41", "17:51", "18:01", "18:11", "18:21", "18:31"]
    let B209_B308_table = ["08:02", "08:12", "08:22", "08:32", "08:42", "08:52", "09:02", "09:12", "09:22", "09:32", "09:42", "09:52", "10:02", "10:17", "10:32", "10:47", "11:02", "11:17", "11:32", "11:47", "12:02", "12:17", "12:32", "12:47", "13:02", "13:17", "13:32", "13:47", "14:02", "14:17", "14:32", "14:47", "15:02", "15:17", "15:32", "15:47", "16:02", "16:12", "16:22", "16:32", "16:42", "16:52", "17:02", "17:12", "17:22", "17:32", "17:42", "17:52", "18:02", "18:12", "18:22", "18:32"]
    let B308_B310_table = ["08:03", "08:13", "08:23", "08:33", "08:43", "08:53", "09:03", "09:13", "09:23", "09:33", "09:43", "09:53", "10:03", "10:18", "10:33", "10:48", "11:03", "11:18", "11:33", "11:48", "12:03", "12:18", "12:33", "12:48", "13:03", "13:18", "13:33", "13:48", "14:03", "14:18", "14:33", "14:48", "15:03", "15:18", "15:33", "15:48", "16:03", "16:13", "16:23", "16:33", "16:43", "16:53", "17:03", "17:13", "17:23", "17:33", "17:43", "17:53", "18:03", "18:13", "18:23", "18:33"]
    let B310_backgate_table = ["08:04", "08:14", "08:24", "08:34", "08:44", "08:54", "09:04", "09:14", "09:24", "09:34", "09:44", "09:54", "10:04", "10:19", "10:34", "10:49", "11:04", "11:19", "11:34", "11:49", "12:04", "12:19", "12:34", "12:49", "13:04", "13:19", "13:34", "13:49", "14:04", "14:19", "14:34", "14:49", "15:04", "15:19", "15:34", "15:49", "16:04", "16:14", "16:24", "16:34", "16:44", "16:54", "17:04", "17:14", "17:24", "17:34", "17:44", "17:54", "18:04", "18:14", "18:24", "18:34"]
    let backgate_sangdo_table = ["08:05", "08:15", "08:25", "08:35", "08:45", "08:55", "09:05", "09:15", "09:25", "09:35", "09:45", "09:55", "10:05", "10:20", "10:35", "10:50", "11:05", "11:20", "11:35", "11:50", "12:05", "12:20", "12:35", "12:50", "13:05", "13:20", "13:35", "13:50", "14:05", "14:20", "14:35", "14:50", "15:05", "15:20", "15:35", "15:50", "16:05", "16:15", "16:25", "16:35", "16:45", "16:55", "17:05", "17:15", "17:25", "17:35", "17:45", "17:55", "18:05", "18:15", "18:25", "18:35"]

    let sangdo_backgate_table = ["08:25", "08:35", "08:45", "08:55", "09:05", "09:15", "09:25", "09:35", "09:45", "09:55", "10:05", "10:15", "10:25", "10:40", "10:55", "11:10", "11:25", "11:40", "11:55", "12:10", "12:25", "12:40", "12:55", "13:10", "13:25", "13:40", "13:55", "14:10", "14:25", "14:40", "14:55", "15:10", "15:25", "15:40", "15:55", "16:10", "16:25", "16:35", "16:45", "16:55", "17:05", "17:15", "17:25", "17:35", "17:45", "17:55", "18:05", "18:15", "18:25", "18:35", "18:45", "18:55"]
    let backgate_B310_table = ["08:31", "08:41", "08:51", "09:01", "09:11", "09:21", "09:31", "09:41", "09:51", "10:01", "10:11", "10:21", "10:31", "10:46", "11:01", "11:16", "11:31", "11:46", "12:01", "12:16", "12:31", "12:46", "13:01", "13:16", "13:31", "13:46", "14:01", "14:16", "14:31", "14:46", "15:01", "15:16", "15:31", "15:46", "16:01", "16:16", "16:31", "16:41", "16:51", "17:01", "17:11", "17:21", "17:31", "17:41", "17:51", "18:01", "18:11", "18:21", "18:31", "18:41", "18:51", "19:01"]
    let B310_B308_table = ["08:32", "08:42", "08:52", "09:02", "09:12", "09:22", "09:32", "09:42", "09:52", "10:02", "10:12", "10:22", "10:32", "10:47", "11:02", "11:17", "11:32", "11:47", "12:02", "12:17", "12:32", "12:47", "13:02", "13:17", "13:32", "13:47", "14:02", "14:17", "14:32", "14:47", "15:02", "15:17", "15:32", "15:47", "16:02", "16:17", "16:32", "16:42", "16:52", "17:02", "17:12", "17:22", "17:32", "17:42", "17:52", "18:02", "18:12", "18:22", "18:32", "18:42", "18:52", "19:02"]
    let B308_B209_table = ["08:33", "08:43", "08:53", "09:03", "09:13", "09:23", "09:33", "09:43", "09:53", "10:03", "10:13", "10:23", "10:33", "10:48", "11:03", "11:18", "11:33", "11:48", "12:03", "12:18", "12:33", "12:48", "13:03", "13:18", "13:33", "13:48", "14:03", "14:18", "14:33", "14:48", "15:03", "15:18", "15:33", "15:48", "16:03", "16:18", "16:33", "16:43", "16:53", "17:03", "17:13", "17:23", "17:33", "17:43", "17:53", "18:03", "18:13", "18:23", "18:33", "18:43", "18:53", "19:03"]
    let B209_B204_table = ["08:34", "08:44", "08:54", "09:04", "09:14", "09:24", "09:34", "09:44", "09:54", "10:04", "10:14", "10:24", "10:34", "10:49", "11:04", "11:19", "11:34", "11:49", "12:04", "12:19", "12:34", "12:49", "13:04", "13:19", "13:34", "13:49", "14:04", "14:19", "14:34", "14:49", "15:04", "15:19", "15:34", "15:49", "16:04", "16:19", "16:34", "16:44", "16:54", "17:04", "17:14", "17:24", "17:34", "17:44", "17:54", "18:04", "18:14", "18:24", "18:34", "18:44", "18:54", "19:04"]
    let B204_bluedragon_table = ["08:35", "08:45", "08:55", "09:05", "09:15", "09:25", "09:35", "09:45", "09:55", "10:05", "10:15", "10:25", "10:35", "10:50", "11:05", "11:20", "11:35", "11:50", "12:05", "12:20", "12:35", "12:50", "13:05", "13:20", "13:35", "13:50", "14:05", "14:20", "14:35", "14:50", "15:05", "15:20", "15:35", "15:50", "16:05", "16:20", "16:35", "16:45", "16:55", "17:05", "17:15", "17:25", "17:35", "17:45", "17:55", "18:05", "18:15", "18:25", "18:35", "18:45", "18:55", "19:05"]
    





    init() {
    
        defaultNode = Node(name: "default", lat: 0, lng: 0)

        sangdo = Node(name: "sangdo", lat: 37.503093, lng: 126.948077)
        backgate = Node(name: "backgate", lat: 37.505005, lng: 126.953959)
        backroad = Node(name: "backroad", lat: 37.504658, lng: 126.954748)
        B305 = Node(name: "B305", lat: 37.504313, lng: 126.954740)

        // 이름바뀜
        B303_6F = Node(name: "B303_6F", lat: 37.504507, lng: 126.955581)
        B303_B1F = Node(name: "B303_B1F", lat: 37.504976, lng: 126.955775)
        B310_1F = Node(name: "B310_1F", lat: 37.504041, lng: 126.955572)
        B310_B3F = Node(name: "B310_B3F", lat: 37.504061, lng: 126.956348)
        B310_B5F = Node(name: "B310_B5F", lat: 37.504417, lng: 126.956890)

        B308 = Node(name: "B308", lat: 37.502919, lng: 126.956933)
        B208 = Node(name: "B208", lat: 37.503781, lng: 126.957024)
        B209 = Node(name: "B209", lat: 37.503725, lng: 126.957600)
        
        haebang = Node(name: "haebang", lat: 37.504603, lng: 126.957400)
        bluedragon = Node(name: "bluedragon", lat: 37.505792, lng: 126.957375)
        B204 = Node(name: "B204", lat: 37.505103, lng: 126.958152)

        //이름바뀜
        B104_3F = Node(name: "B104_3F", lat: 37.505838, lng: 126.958352)
        B104_1F = Node(name: "B104_1F", lat: 37.50586, lng: 126.95835)


        B106 = Node(name: "B106", lat: 37.505179, lng: 126.958640)
        ppaegwang = Node(name: "ppaegwang", lat: 37.506161, lng: 126.957602)

        grass = Node(name: "grass", lat: 37.506729, lng: 126.958026)
        B101 = Node(name: "B101", lat: 37.506058, lng: 126.958030)
        B102 = Node(name: "B102", lat: 37.506423, lng: 126.958507)
        frontgate = Node(name: "frontgate", lat: 37.506813, lng: 126.958459)
        heukseok = Node(name: "heukseok", lat: 37.509124, lng: 126.963283)







    
        // 엣지 많음, flag: 도보:0 , 계단:1, 버스:2 , 엘리베이터:3
        sangdo_backgate = Edge(from: sangdo, to: backgate, meters: 607, time_needed: 11, flag: 0)

        backroad_backgate = Edge(from: backroad, to: backgate, meters: 129, time_needed: 2, flag: 0)
        backroad_B305 = Edge(from: backroad, to: B305, meters: 60, time_needed: 1, flag: 0)
        backroad_B303F6 = Edge(from: backroad, to: B303_6F, meters: 60, time_needed: 1, flag: 0)
        backroad_B310F1 = Edge(from: backroad, to: B310_1F, meters: 61, time_needed: 1, flag: 0)


        B310F1_B308 = Edge(from: B310_1F, to: B308, meters: 152, time_needed: 3, flag: 0)
        B308_B208 = Edge(from: B308, to: B208, meters: 126, time_needed: 3, flag: 0)
        B308_B209 = Edge(from: B308, to: B209, meters: 146, time_needed: 4, flag: 0)
        B209_B208 = Edge(from: B209, to: B208, meters: 20, time_needed: 1, flag: 0)
        B208_B310F3 = Edge(from: B208, to: B310_B3F, meters: 69, time_needed: 1, flag: 0)


        haebang_B310F1 = Edge(from: haebang, to: B310_1F, meters: 154, time_needed: 4, flag: 1) // 계단
        haebang_B310F3 = Edge(from: haebang, to: B310_B3F, meters: 120, time_needed: 3, flag: 1) // 계단
        haebang_B310F5 = Edge(from: haebang, to: B310_B5F, meters: 55, time_needed: 1, flag: 0)
        haebang_B303F6 = Edge(from: haebang, to: B303_6F, meters: 205, time_needed: 6, flag: 1) // 계단
        haebang_B303F1 = Edge(from: haebang, to: B303_B1F, meters: 146, time_needed: 2, flag: 0)
        haebang_B204_1 = Edge(from: haebang, to: B204, meters: 100, time_needed: 1, flag: 1) // 계단
        haebang_B204_0 = Edge(from: haebang, to: B204, meters: 125, time_needed: 2, flag: 0)


        B204_B209 = Edge(from: B204, to: B209, meters: 197, time_needed: 5, flag: 0)
        B204_B106 = Edge(from: B204, to: B106, meters: 45, time_needed: 1, flag: 0)
        B204_B104F3 = Edge(from: B204, to: B104_3F, meters: 129, time_needed: 2, flag: 0)
        B204_bluedragon = Edge(from: B204, to: bluedragon, meters: 127, time_needed: 2, flag: 0)

        bluedragon_haebang = Edge(from: bluedragon, to: haebang, meters: 164, time_needed: 5, flag: 1) // 계단
        bluedragon_B303F1 = Edge(from: bluedragon, to: B303_B1F, meters: 148, time_needed: 4, flag: 1) // 계단
        bluedragon_B303F6 = Edge(from: bluedragon, to: B303_6F, meters: 200, time_needed: 7, flag: 1) // 계단


        B106_B104F3 = Edge(from: B106, to: B104_3F, meters: 30, time_needed: 1, flag: 0)
        grass_B101 = Edge(from: grass, to: B101, meters: 50, time_needed: 1, flag: 0)
        grass_B102 = Edge(from: grass, to: B102, meters: 32, time_needed: 1, flag: 0)
        grass_B104F1 = Edge(from: grass, to: B104_1F, meters: 50, time_needed: 1, flag: 0)
        grass_B104F3 = Edge(from: grass, to: B104_3F, meters: 60, time_needed: 3, flag: 1)
        grass_ppaegwang = Edge(from: grass, to: ppaegwang, meters: 80, time_needed: 2, flag: 0)
        grass_frontgate = Edge(from: grass, to: frontgate, meters: 30, time_needed: 1, flag: 0)
        heukseok_frontgate = Edge(from: heukseok, to: frontgate, meters: 545, time_needed: 8, flag: 0)
        ppaegwang_bleudragon = Edge(from: ppaegwang, to: bluedragon, meters: 30, time_needed: 1, flag: 0)


        // 엘리베이터
        B310F1_B310F3 = Edge(from: B310_1F, to: B310_B3F, meters: 0, time_needed: 1, flag: 3)
        B310F3_B310F5 = Edge(from: B310_B3F, to: B310_B5F, meters: 0, time_needed: 1, flag: 3)
        B303F6_B303F1 = Edge(from: B303_6F, to: B303_B1F, meters: 0, time_needed: 1, flag: 3)
        B104F3_B104F1 = Edge(from: B104_3F, to: B104_1F, meters: 0, time_needed: 1, flag: 3)




        // 버스... 엣지 추가하기.. 방향마다 시간이 다르기때문에 각각 추가해야
        bluedragon_B204_bus = Edge(from: bluedragon, to: B204, meters: 210, time_needed: 1, flag: 2)
        B204_B209_bus = Edge(from: B204, to: B209, meters: 151, time_needed: 1, flag: 2)
        B209_B308_bus = Edge(from: B209, to: B308, meters: 146, time_needed: 1, flag: 2)
        B308_B310_bus = Edge(from: B308, to: B310_1F, meters: 152, time_needed: 1, flag: 2)
        B310_backgate_bus = Edge(from: B310_1F, to: backgate, meters: 278, time_needed: 1, flag: 2)
        backgate_sangdo_bus = Edge(from: backgate, to: sangdo, meters: 992, time_needed: 6, flag: 2)
        sangdo_backgate_bus = Edge(from: sangdo, to: backgate, meters: 992, time_needed: 6, flag: 2)
        backgate_B310_bus = Edge(from: backgate, to: B310_1F, meters: 278, time_needed: 1, flag: 2)
        B310_B308_bus = Edge(from: B310_1F, to: B308, meters: 112, time_needed: 1, flag: 2)
        B308_B209_bus = Edge(from: B308, to: B209, meters: 146, time_needed: 1, flag: 2)
        B209_B204_bus = Edge(from: B209, to: B204, meters: 151, time_needed: 1, flag: 2)
        B204_bluedragon_bus = Edge(from: B204, to: bluedragon, meters: 210, time_needed: 1, flag: 2)


    }

    



    
    

    
    
}
