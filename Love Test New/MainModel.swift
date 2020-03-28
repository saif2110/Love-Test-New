//
//  MainModel.swift
//  Love Test New
//
//  Created by Junaid Mukadam on 26/03/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

var question = ""
var option = [String]()
var MyName = "GOGO"
var partnersName = "Saif"
var selectedAnswer = ""
var quetionNumber = 1
var correctAnswer = 0
var ranDome = [Int]()


class QuetionAnswer {
    var Quetion:String!
    var YouAnswer:String!
    var PartnerAnswer:String!
    
    init(Quetion:String,YouAnswer:String,PartnerAnswer:String) {
        self.Quetion = Quetion
        self.YouAnswer = YouAnswer
        self.PartnerAnswer = PartnerAnswer
    }
}



func make10(){
    repeat{
        let num = Int.random(in: 1 ... 34)
        ranDome.append(num)
        ranDome = Array(Set(ranDome))
    }while ranDome.count != 11
}


func doCal(){

    if let path = Bundle.main.path(forResource: "que", ofType: "json") {
        let data = NSData(contentsOfFile: path)
        let json = JSON(data!)
        question = json["Question\(ranDome[quetionNumber-1])"]["Qus"].string!
        if question.contains("john's") {
            question = question.replacingOccurrences(of: "john's", with: partnersName+"'s")
        }else if question.contains("john"){
            question = question.replacingOccurrences(of: "john", with: partnersName)
        }
        for i in json["Question\(ranDome[quetionNumber-1])"]["answer"] {
            option.append(i.1.string!)
        }
    }
}
