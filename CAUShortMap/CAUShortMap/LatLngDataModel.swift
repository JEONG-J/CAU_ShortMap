//
//  Node.swift
//  CAUShortMap
//
//  Created by 정의찬 on 12/9/23.
//

import Foundation
import UIKit
struct Node: Hashable {
   let name: String
   let lat: Double?
   let lng: Double?
}

struct BuildingName {
    var name: String
}

final class CAUModel {
    
    static let buildingName: [BuildingName] = [
        BuildingName(name: "상도역"),
        BuildingName(name: "후문"),
        BuildingName(name: "후문에서 310관 가는 길"),
        BuildingName(name: "305관"),
        BuildingName(name: "303관 6층"),
        BuildingName(name: "303관 지하 1층"),
        BuildingName(name: "310관 1층"),
        BuildingName(name: "310관 지하 3층"),
        BuildingName(name: "310관 지하 5층"),
        BuildingName(name: "308관 기숙사"),
        BuildingName(name: "208관 공대"),
        BuildingName(name: "209관 공대"),
        BuildingName(name: "해방광장"),
        BuildingName(name: "청룡탕"),
        BuildingName(name: "204관 중도"),
        BuildingName(name: "104관 자과대 3층"),
        BuildingName(name: "104관 자과대 1층"),
        BuildingName(name: "106관 의대"),
        BuildingName(name: "빼빼로 광장"),
        BuildingName(name: "영신관 앞 마당"),
        BuildingName(name: "101관 영신관"),
        BuildingName(name: "102관 약대"),
        BuildingName(name: "정문"),
        BuildingName(name: "흑석역")
    ]
    
    let sangdo: Node = Node(name: "상도역", lat: 37.503093, lng: 126.948077)
    let backgate: Node = Node(name: "후문", lat: 37.505005, lng: 126.953959)
    let backroad: Node = Node(name: "후문에서 310관 가는 길", lat: 37.504658, lng: 126.954748)
    let B305: Node = Node(name: "305관", lat: 37.504313, lng: 126.954740)
    let B303_F6: Node = Node(name: "법학관 6층", lat: 37.504507, lng: 126.955581)
    let B303_F1: Node = Node(name: "법학관 지하 1층", lat: 37.504976, lng: 126.955775)
    let B310_F1: Node = Node(name: "310관 1층", lat: 37.504041, lng: 126.955572)
    let B310_F3: Node = Node(name: "310관 지하 3층", lat: 37.504061, lng: 126.956348)
    let B310_F5: Node = Node(name: "310관 지하 5층", lat: 37.504417, lng: 126.956890)
    let B308: Node = Node(name: "308관 기숙사", lat: 37.502919, lng: 126.956933)
    let B208: Node = Node(name: "208관", lat: 37.503781, lng: 126.957024)
    let B209: Node = Node(name: "209관", lat: 37.503725, lng: 126.957600)
    let haebang: Node = Node(name: "해방광장", lat: 37.504603, lng: 126.957400)
    let bluedragon: Node = Node(name: "청룡탕", lat: 37.505792, lng: 126.957375)
    let B204: Node = Node(name: "중앙대 도서관",  lat: 37.505103, lng: 126.958152)
    
    let B104_F3: Node = Node(name: "104관 3층", lat: 37.505838, lng: 126.958352)
    let B104_F1: Node = Node(name: "104관 1층",  lat: 37.50586, lng: 126.95835)
    let B106: Node = Node(name: "106관", lat: 37.505179, lng: 126.958640)
    let ppaegwang: Node = Node(name: "빼광", lat: 37.506161, lng: 126.957602)
    let grass: Node = Node(name: "영신관 앞 마당", lat: 37.506729, lng: 126.958026)
    let B101: Node = Node(name: "영신관", lat: 37.506058, lng: 126.958030)
    let B102: Node = Node(name: "102관", lat: 37.506423, lng: 126.958507)
    let frontGate: Node = Node(name: "정문", lat: 37.506813, lng: 126.958459)
    let heukseok: Node = Node(name: "흑석역", lat: 37.509124, lng: 126.963283)
    
    public func getLocationData(for keyWord: String) -> Node? {
        switch keyWord{
        case "상도역":
            return sangdo
        case "후문":
            return backgate
        case "후문에서 310관 가는 길":
            return backroad
        case "305관":
            return B305
        case "303관 6층":
            return B303_F6
        case "303관 지하 1층":
            return B303_F1
        case "310관 1층":
            return B310_F1
        case "310관 지하 3층":
            return B310_F3
        case "310관 지하 5층":
            return B310_F5
        case "308관 기숙사":
            return B308
        case "208관 공대":
            return B208
        case "209관 공대":
            return B209
        case "해방광장":
            return haebang
        case "청룡탕":
            return bluedragon
        case "204관 중도":
            return B204
        case "104관 자과대 3층":
            return B104_F3
        case "104관 자과대 1층":
            return B104_F1
        case "106관 의대":
            return B106
        case "빼빼로 광장":
            return ppaegwang
        case "영신관 앞 마당":
            return grass
        case "101관 영신관":
            return B101
        case "102관 약대":
            return B102
        case "정문":
            return frontGate
        case "흑석역":
            return heukseok
        default:
            return nil
        }
    }
}
