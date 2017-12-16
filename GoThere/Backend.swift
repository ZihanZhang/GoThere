//
//  Backend.swift
//  GoThere
//
//  Created by Zihan Zhang on 2017/12/13.
//  Copyright © 2017年 Zihan Zhang. All rights reserved.
//

import Foundation
import UIKit

class recommendation {
    let picture: UIImage
    let discription: String
    let details: [UIImage]
    
    init(picture: UIImage, discription: String, details:[UIImage]) {
        self.picture = picture
        self.discription = discription
        self.details = details
    }
}

var recommendations: [recommendation] = []

var SignedIn = false

var sportLib: [String] = ["Ball"]
var shoppingLib: [String] = ["Mall"]
var historyLib: [String] = ["History"]
var natureLib: [String] = ["Nature"]
var souvenirLib: [String] = ["Souvenir"]
var outdoorLib: [String] = ["Outdoor"]
var entertainmentLib: [String] = ["Entertainment"]
var foodLib: [String] = ["Food"]

func start() {
    let bostoncommon: recommendation = recommendation(picture: #imageLiteral(resourceName: "bostoncommon.jpeg"), discription: "bostoncommon", details:[])
    let charlesriver: recommendation = recommendation(picture: #imageLiteral(resourceName: "charlesriver.jpeg"), discription: "charlesriver", details: [])
    let harbor: recommendation = recommendation(picture: #imageLiteral(resourceName: "harbor.jpeg"), discription: "harbor", details: [])
    
    recommendations.append(bostoncommon)
    recommendations.append(charlesriver)
    recommendations.append(harbor)
}


