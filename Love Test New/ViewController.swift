//
//  ViewController.swift
//  Love Test New
//
//  Created by Junaid Mukadam on 19/09/19.
//  Copyright © 2019 Saif Mukadam. All rights reserved.
//

import UIKit

var selectedAge = ""
var selectedGender = ""

class ViewController: UIViewController {
    @IBOutlet weak var topCont: NSLayoutConstraint!
    @IBOutlet weak var goBut: UIButton!
    @IBOutlet weak var female: UIImageView!
    @IBOutlet weak var man: UIImageView!
    @IBOutlet weak var but1: UIButton!{
        didSet{
            BorderBut(but: but1,titel:"18+")

        }
    }
    @IBOutlet weak var but2: UIButton!
    {
        didSet{
            BorderBut(but: but2,titel:"22+")
        }
    }
    @IBOutlet weak var but3: UIButton!{
        didSet{
            BorderBut(but:but3,titel:"28+")

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if UIDevice.current.name != "iPhone SE" || UIDevice.current.name != "iPhone 4S"  {
            topCont.constant = 100
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer()
        female.addGestureRecognizer(tap)
        tap.addTarget(self, action: #selector(womenBut))
        female.isUserInteractionEnabled = true
        
        let tap2 = UITapGestureRecognizer()
        man.addGestureRecognizer(tap2)
        man.isUserInteractionEnabled = true
        tap2.addTarget(self, action: #selector(menBut))
    }
    
    
    @IBAction func allButs(_ sender: UIButton) {
        if sender.tag == 0 {
        Button(ButtontobeSelected: but1)
            
        }else if sender.tag == 1{
            Button(ButtontobeSelected: but2)
        }else{
            Button(ButtontobeSelected: but3)
        }
    }
    
    @objc func menBut(){
        Image(imagetobeSelected: man, imagetobeDeselected: female)
    }

    
    @objc func womenBut(){
                Image(imagetobeSelected: female, imagetobeDeselected: man)
    }
    
    
    func BorderBut(but:UIButton,titel:String) {
        but.layer.borderWidth = 2
        but.layer.borderColor = UIColor.white.cgColor
        but.layer.cornerRadius = 3
        but.clipsToBounds = true
        but.setTitle(titel, for: .normal)
    }
    
    func Image(imagetobeSelected:UIImageView,imagetobeDeselected:UIImageView) {
        imagetobeSelected.layer.borderWidth = 3
        imagetobeSelected.layer.borderColor = UIColor.green.cgColor
        imagetobeSelected.layer.cornerRadius = 4
        imagetobeSelected.clipsToBounds = true
        imagetobeDeselected.layer.borderWidth = 0
        imagetobeDeselected.layer.borderColor = UIColor.clear.cgColor
        
        if imagetobeSelected.tag == 0{
            
            selectedGender = "man"
        }else{
            
            selectedGender = "woman"
        }
        //print(selectedGender)
        goBut.isEnabled = goEnable()
       }
    
    
    func Button(ButtontobeSelected:UIButton) {
        but1.layer.borderWidth = 2
        but1.layer.borderColor = UIColor.white.cgColor
        but1.layer.cornerRadius = 3
        but2.layer.borderWidth = 2
        but2.layer.borderColor = UIColor.white.cgColor
        but2.layer.cornerRadius = 3
        but3.layer.borderWidth = 2
        but3.layer.borderColor = UIColor.white.cgColor
        but3.layer.cornerRadius = 3
        
        ButtontobeSelected.layer.borderWidth = 3
        ButtontobeSelected.layer.borderColor = UIColor.green.cgColor
        ButtontobeSelected.layer.cornerRadius = 4
        ButtontobeSelected.clipsToBounds = true
        
        selectedAge = ButtontobeSelected.titleLabel?.text ?? ""
        //print(selectedAge)
        
        goBut.isEnabled = goEnable()
    
    }
    
    
    func goEnable() -> Bool{
        if selectedAge == "" || selectedGender == "" {
            
            return false
        }else{
            
            return true
        }
    }

}

extension UIViewController {
    func showAlertMessage(titleStr:String, messageStr:String) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
    }
}
