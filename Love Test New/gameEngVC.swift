//
//  gameEngVC.swift
//  Love Test New
//
//  Created by Junaid Mukadam on 23/03/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import SwiftyJSON

var question = ""
var option = [String]()
var partnersName = "Saif"
var selectedAnswer = ""


class gameEngVC: UIViewController {
    @IBOutlet weak var questionBut: UIButton!
    @IBOutlet weak var line: UIView!
    var previousAnswer = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scenePlayer1()
        scenePlayer2()
    }
    
    func removeScene1(){
        UIView.transition(with: Player1, duration: 1, options: .transitionFlipFromLeft, animations: {
            self.Player1.removeFromSuperview()
            
        })
        UIView.transition(with: Player2, duration: 1, options: .transitionFlipFromLeft, animations: {
            self.Player2.removeFromSuperview()
        })
        
        scenePlayer1(Waited: true)
        
        scenePlayer2(Waited: false)
        
    }
    
    func scenePlayer1(Waited:Bool = false){
        self.view.addSubview(Player1)
        Player1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            Player1.topAnchor.constraint(equalTo: line.bottomAnchor),
            Player1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 10),
            Player1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -10),
            Player1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        
        if let path = Bundle.main.path(forResource: "que", ofType: "json") {
            let data = NSData(contentsOfFile: path)
            let num = String(Int.random(in: 1 ... 34))
            
            let json = JSON(data!)
            
            question = json["Question\(num)"]["Qus"].string!
            
            if question.contains("john's") {
                question = question.replacingOccurrences(of: "john's", with: partnersName+"'s")
            }else if question.contains("john"){
                question = question.replacingOccurrences(of: "john", with: partnersName)
            }
            
            for i in json["Question\(num)"]["answer"] {
                option.append(i.1.string!)
            }
        }
        
        Player1.updateSide(tex: "Your Turn 💬")
        Player1.updateQuetion(tex: question)
        Player1.updateoptionArray(array: option)
        Player1.enableWait(trueFlase: Waited)
       
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(Answerd),
                                               name: NSNotification.Name("Answerd"),
                                               object: nil)
    }
    
    @objc func Answerd(){
        removeScene1()
        
    }
    
    
    func scenePlayer2(Waited:Bool = true){
        
        self.view.addSubview(Player2)
        Player2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            Player2.topAnchor.constraint(equalTo: self.view.topAnchor),
            Player2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 10),
            Player2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -10),
            Player2.bottomAnchor.constraint(equalTo: line.topAnchor)
        ])
        
        Player2.transform = CGAffineTransform(scaleX: -1, y: -1)
        Player2.updateSide(tex: partnersName+"'s Turn 💬")
        Player2.updateQuetion(tex: question)
        Player2.updateoptionArray(array: option)
        
        Player2.enableWait(trueFlase: Waited)
    NotificationCenter.default.addObserver(self,selector:#selector(Answerd),name:NSNotification.Name("Answerd"),object: nil)
        
    }
    
    
    lazy var Player1:PlayerView = {
        let player = PlayerView()
        return player
    }()
    
    lazy var Player2:PlayerView = {
        let player = PlayerView()
        return player
    }()
}
