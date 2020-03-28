//
//  NameingController.swift
//  Love Test New
//
//  Created by Junaid Mukadam on 23/09/19.
//  Copyright © 2019 Saif Mukadam. All rights reserved.
//

import UIKit
import SwiftySound

class NameingController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var partnerName: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var yourName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partnerName.delegate = self
        yourName.delegate = self
        image.image = UIImage(named: selectedGender)
        yourName.attributedPlaceholder = NSAttributedString(string: "Enter Your Name",
        attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.225075349, green: 0.0006390967777, blue: 0.02598414473, alpha: 1)])
        partnerName.attributedPlaceholder = NSAttributedString(string: "Enter Your Partners Name",
        attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.225075349, green: 0.0006390967777, blue: 0.02598414473, alpha: 1)])
        selectedAge = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= 15
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
        if textField == yourName{
             let str = textField.text
             yourName.text = str?.capitalized
        }else{
             let str = textField.text
             partnerName.text = str?.capitalized
        }
        
    }

    @IBAction func go(_ sender: Any) {
            Sound.play(file: "pop.mp3")
            if partnerName.text?.count != 0{
                let next = self.storyboard?.instantiateViewController(withIdentifier: "gameEngVC") as! gameEngVC
                partnersName = partnerName.text!
                MyName = yourName.text!
                self.show(next, sender: self)
                
            }else{
                let alert = UIAlertController(title: "Alert", message: "Partner Name Can't be blank", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                      switch action.style{
                      case .default:
                            print("default")

                      case .cancel:
                            print("cancel")

                      case .destructive:
                            print("destructive")

                    }}))
                self.present(alert, animated: true, completion: nil)
                
            }
    }

}
