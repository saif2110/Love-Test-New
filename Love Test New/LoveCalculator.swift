//
//  LoveCalculator.swift
//  Love Test New
//
//  Created by Junaid Mukadam on 23/09/19.
//  Copyright © 2019 Saif Mukadam. All rights reserved.
//
import UIKit
import EFCountingLabel
import AudioToolbox
import SwiftFireworks

class LoveCalculator: UIViewController {

    var yourFistchar = ""
     var yourLastchar = ""
    
    var partnerFistcar = ""
     var partnerLastcar = ""
     var total = 0
    
    private var updateTimer : Timer?
    private var currentCount : Int?
    private var maxCount : Int?
    
    @IBOutlet weak var displayName: UILabel!
    
    @IBOutlet weak var share: UIButton!
    
    @IBOutlet weak var countDisply: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayName.text = YourName.uppercased() + " ❤️ " + PartnerName.uppercased()
        
        yourFistchar = "Y"
        yourLastchar =  "U"
        
        partnerFistcar = String(PartnerName.first!).lowercased()
        partnerLastcar = String(PartnerName.last!).lowercased()
        
        total = getValue(char: yourFistchar) +  getValue(char: yourLastchar) + getValue(char: partnerFistcar) + getValue(char: partnerLastcar)
        
            DispatchQueue.main.async {
                self.maxCount = self.total
                self.currentCount = 0
                self.updateTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.updateLabel), userInfo: nil, repeats: true)
               }
    }
    
    
    @IBAction func shareAction(_ sender: Any){
        // text to share
        let text:String = "Love score of: \(YourName.uppercased()) ❤️ \(PartnerName.uppercased()) is \(total). Download to see how much you love. https://apps.apple.com/us/developer/junaid-mukadam/id1365586675"

              // set up activity view controller
              let textToShare = [ text ]
              let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
              activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

              // exclude some activity types from the list (optional)
           activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

              // present the view controller
              self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    
    @objc func updateLabel() {
        countDisply.setTitle("  " + String(currentCount!) + "%", for: .normal)
    
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.10
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: countDisply.center.x - 10, y: countDisply.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: countDisply.center.x + 10, y: countDisply.center.y))
        countDisply.layer.add(animation, forKey: "position")
        currentCount! += 1
        
        if currentCount! > 80 {
        SwiftFireworks.sharedInstance.showFirework(inView: view, andPosition: CGPoint( x:CGFloat( arc4random_uniform( UInt32( floor( self.view.frame.width  ) ) ) ),
       y:CGFloat( arc4random_uniform( UInt32( floor( self.view.frame.height ) ) ) )
        ))
            let a:UIImage = countDisply.currentBackgroundImage!.withRenderingMode(.alwaysTemplate)
            
            countDisply.setBackgroundImage(a, for: .normal)
          AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
        
           if currentCount == maxCount {
            share.isHidden = false
        }
        
        
        if currentCount! > maxCount! {
            /// Release All Values
            self.updateTimer?.invalidate()
            self.updateTimer = nil
            self.maxCount = nil
            self.currentCount = nil
        }
    }

}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}
