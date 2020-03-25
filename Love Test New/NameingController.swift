//
//  NameingController.swift
//  Love Test New
//
//  Created by Junaid Mukadam on 23/09/19.
//  Copyright © 2019 Saif Mukadam. All rights reserved.
//

import UIKit

class NameingController: UIViewController,UITextFieldDelegate{

    @IBOutlet weak var partnerName: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        partnerName.delegate = self
        image.image = UIImage(named: selectedGender)
        partnerName.attributedPlaceholder = NSAttributedString(string: "Enter Your Partners Name",
        attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.225075349, green: 0.0006390967777, blue: 0.02598414473, alpha: 1)])
        selectedAge = ""
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let str = textField.text
        if str?.count != 0 {
            partnerName.text = str?.capitalized
        }
    }

    @IBAction func go(_ sender: Any) {
            if partnerName.text?.count != 0{
                PartnerName = partnerName.text!
                
                let next = self.storyboard?.instantiateViewController(withIdentifier: "gameEngVC") as! gameEngVC
                partnersName = partnerName.text!
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
