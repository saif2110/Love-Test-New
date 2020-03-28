//
//  RightWrong.swift
//  Love Test New
//
//  Created by Junaid Mukadam on 26/03/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit

class RightWrong: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var quetion: UILabel!
    @IBOutlet weak var byLabel: UILabel!
    @IBOutlet weak var partnerlabel: UILabel!
    
    func clrofWidth(clr:UIColor = UIColor.white) {
        view.layer.borderWidth = 2
        view.layer.borderColor = clr.cgColor
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clrofWidth(clr: .systemRed)
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
    }
    
}
