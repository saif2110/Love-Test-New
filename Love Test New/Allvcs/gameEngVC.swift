//
//  gameEngVC.swift
//  Love Test New
//
//  Created by Junaid Mukadam on 23/03/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import SwiftyJSON
import SwiftySound

class gameEngVC: UIViewController {
    @IBOutlet weak var questionBut: UIButton!
    @IBOutlet weak var line: UIView!
    var previousAnswer = ""
    var AllQuestionAnswer = [QuetionAnswer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        make10()
        questionBut.setTitle("Q " + String(quetionNumber), for: .normal)
        scenePlayer1()
        scenePlayer2()
    }
    
    func removeScene1(){
        NotificationCenter.default.removeObserver(self, name: Notification.Name("Answerd"), object: nil)
        
        
        UIView.transition(with: Player1, duration: 1, options: .transitionFlipFromLeft, animations: {
            self.Player1.removeFromSuperview()
        })
        UIView.transition(with: Player2, duration: 1, options: .transitionFlipFromLeft, animations: {
            self.Player2.removeFromSuperview()
        })
        option.removeAll()
        scenePlayer1(Waited: true)
        scenePlayer2(Waited: false)
        
    }
    
    func removeScene2(){
        
        
        NotificationCenter.default.removeObserver(self, name: Notification.Name("Answerd"), object: nil)
        
        if quetionNumber == 10 {
            let next = self.storyboard?.instantiateViewController(withIdentifier: "LoveCalculator") as! LoveCalculator
            next.array = AllQuestionAnswer
            next.RightAnswer = Double(correctAnswer)
            self.show(next, sender: self)
        }
        
        UIView.transition(with: Player1, duration: 1, options: .transitionFlipFromLeft, animations: {
            self.Player1.removeFromSuperview()
        })
        UIView.transition(with: Player2, duration: 1, options: .transitionFlipFromLeft, animations: {
            self.Player2.removeFromSuperview()
        })
        quetionNumber += 1
        questionBut.setTitle("Q " + String(quetionNumber), for: .normal)
        option.removeAll()
        scenePlayer2(Waited: true)
        scenePlayer1(Waited: false)
        
    }
    
    func scenePlayer1(Waited:Bool = false){
        doCal()
        self.view.addSubview(Player1)
        Player1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            Player1.topAnchor.constraint(equalTo: line.bottomAnchor),
            Player1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 10),
            Player1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -10),
            Player1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        Player1.updateSide(tex: MyName + "'s Turn 💬")
        Player1.updateQuetion(tex: question)
        Player1.updateoptionArray(array: option)
        Player1.enableWait(trueFlase: Waited)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(Answerd),
                                               name: NSNotification.Name("Answerd"),
                                               object: nil)
    }
    
    var isPlayer1Turn = false
    @objc func Answerd(){
        isPlayer1Turn.toggle()
        
        
        if !isPlayer1Turn {
     
            AllQuestionAnswer.append(QuetionAnswer(Quetion: question, YouAnswer: Player1.answerIS(), PartnerAnswer: Player2.answerIS()))
        }
        
        
        if Player1.answerIS() == Player2.answerIS(){
           Sound.play(file: "correct.mp3")
           correctAnswer += 1
        }else if Player1.answerIS() != Player2.answerIS() && !isPlayer1Turn {
            Sound.play(file: "wrong.mp3")
        }
        
        if isPlayer1Turn{
            removeScene1()
        }else{
            removeScene2()
        }
        
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
        
        if question.contains(partnersName+"'s"){
            question = question.replacingOccurrences(of: partnersName+"'s", with: "your")
        }else if question.contains(partnersName){
            question = question.replacingOccurrences(of: partnersName, with: "you")
        }
        
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
