//
//  Options.swift
//  Love Test New
//
//  Created by Junaid Mukadam on 24/03/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import UIKit

class Options: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 0.5
    }
    
}
