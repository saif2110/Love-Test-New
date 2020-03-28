//
//  StartScreenVC.swift
//  Love Test New
//
//  Created by Junaid Mukadam on 28/03/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit
import SwiftySound

class StartScreenVC: UIViewController {
    
    @IBOutlet weak var soundBut: UIButton!
    
    @IBOutlet weak var startBut: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startBut.layer.borderWidth = 1
        startBut.layer.borderColor = UIColor.black.cgColor
        startBut.layer.cornerRadius = 10
        startBut.clipsToBounds = true

    }
    
    @IBAction func soundButAC(_ sender: Any) {
        if soundBut.currentImage ==  #imageLiteral(resourceName: "greyBut") {
            soundBut.setImage(#imageLiteral(resourceName: "redBut"), for: .normal)
            Snd?.resume()
        }else{
            soundBut.setImage(#imageLiteral(resourceName: "greyBut"), for: .normal)
             Snd?.pause()
        }
    }
}


