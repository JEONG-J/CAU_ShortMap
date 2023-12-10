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
    
    let sangdo: Node = Node(name: "상도역", lat: 37.50331, lng: 126.94817)
    let backgate: Node = Node(name: "후문", lat: 37.50499, lng: 126.95394)
    let backroad: Node = Node(name: "후문에서 310관 가는 길", lat: 37.50471, lng: 126.95466)
    let B305: Node = Node(name: "305관", lat: 37.50437, lng: 126.95466)
    let B303_F6: Node = Node(name: "법학관 6층", lat: 37.50449, lng: 126.95575)
    let B303_F1: Node = Node(name: "법학관 지하 1층", lat: 37.50489, lng: 126.95594)
    let B310_F1: Node = Node(name: "310관 1층", lat: 37.50388, lng: 126.95565)
    let B310_F3: Node = Node(name: "310관 지하 3층", lat: 37.5041, lng: 126.95651)
    let B310_F5: Node = Node(name: "310관 지하 5층", lat: 37.5044, lng: 126.95689)
    let B308: Node = Node(name: "308관 기숙사", lat: 37.50289, lng: 126.95689)
    let B208: Node = Node(name: "208관", lat: 37.50372, lng: 126.95709)
    let B209: Node = Node(name: "209관", lat: 37.50377, lng: 126.95763)
    let haebang: Node = Node(name: "해방광장", lat: 37.50415, lng: 126.95729)
    let bluedragon: Node = Node(name: "청룡탕", lat: 37.50562, lng: 126.95727)
    let B204: Node = Node(name: "중앙대 도서관", lat: 37.50475, lng: 126.95803)
    let B104_F3: Node = Node(name: "104관 3층", lat: 37.50552, lng: 126.95834)
    let B104_F1: Node = Node(name: "104관 1층", lat: 37.50586, lng: 126.95835)
    let B106: Node = Node(name: "106관", lat: 37.50515, lng: 126.9588)
    let ppaegwang: Node = Node(name: "빼광", lat: 37.50602, lng: 126.95746)
    let grass: Node = Node(name: "영신관 앞 마당", lat: 37.50643, lng: 126.95806)
    let B101: Node = Node(name: "영신관", lat: 37.50595, lng: 126.95801)
    let B102: Node = Node(name: "102관", lat: 37.50649, lng: 126.95882)
    let frontGate: Node = Node(name: "정문", lat: 37.5068, lng: 126.95841)
    let heukseok: Node = Node(name: "흑석역", lat: 37.50869, lng: 126.96387)
    
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
