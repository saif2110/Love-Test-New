//
//  LoveCalculator.swift
//  Love Test New
//
//  Created by Junaid Mukadam on 23/09/19.
//  Copyright © 2019 Saif Mukadam. All rights reserved.
//
import UIKit
import AudioToolbox
import SwiftFireworks
import SwiftySound


class LoveCalculator: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("RightWrong", owner: self, options: nil)?.first as! RightWrong
        cell.quetion.text =  array[indexPath.row].Quetion
        cell.byLabel.text =  MyName + " - " + array[indexPath.row].YouAnswer
        cell.partnerlabel.text = partnersName + " - " + array[indexPath.row].PartnerAnswer
        
        if array[indexPath.row].YouAnswer == array[indexPath.row].PartnerAnswer {
            cell.clrofWidth(clr: .systemRed)
        }else{
            cell.clrofWidth(clr: .black)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 134
    }
    
    
    @IBOutlet weak var myView: UITableView!
    
    @IBOutlet weak var allAnswers: UILabel!
    
    var RightAnswer:Double = 1
    var WrongAnswer:Double = 0
    
    var total = 0
    var array = [QuetionAnswer]()
    
    private var updateTimer : Timer?
    private var currentCount : Int?
    private var maxCount : Int?
    
    @IBOutlet weak var displayName: UILabel!
    
    @IBOutlet weak var share: UIButton!
    
    @IBOutlet weak var countDisply: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allAnswers.text = String(Int(RightAnswer)) + " Right Answers"
        myView.backgroundColor = .clear
        myView.delegate = self
        myView.dataSource = self
        myView.reloadData()

        var rand = 0
        if RightAnswer < 10{
            rand = Int.random(in: 0 ... 5)
        }
        total = (Int(RightAnswer) * 10) + rand
        WrongAnswer = 10 - RightAnswer
        displayName.text = MyName.uppercased() + " ❤️ " + partnersName.uppercased()
       
        
        DispatchQueue.main.async {
            self.maxCount = self.total
            self.currentCount = 0
            self.updateTimer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(self.updateLabel), userInfo: nil, repeats: true)
        }
//
//        let viewLayer = PieCustomViewsLayer()
//        let settings = PieCustomViewsLayerSettings()
//        settings.viewRadius = 55
//        settings.hideOnOverflow = false
//        viewLayer.settings = settings
//
//        viewLayer.viewGenerator = {slice, center in
//            let myView = UIView()
//            let View = UILabel()
//            View.textColor = .black
//            View.font = UIFont(name: "Gill Sans", size: 12)
//            if slice.data.id == 1 {
//                View.frame = CGRect(x: 0, y: -30, width: 100, height: 15)
//                View.text =  String(Int(self.RightAnswer)) + " Right Answers"
//            }else{
//                View.frame = CGRect(x: 0, y: 30, width: 100, height: 15)
//                View.text = String(Int(self.WrongAnswer)) + " Wrong Answers"
//            }
//
//            myView.addSubview(View)
//            return myView
//        }
//
//        pie.layers = [viewLayer]
//        if RightAnswer == 0 {
//            pie.models.append(PieSliceModel(value: WrongAnswer, color: UIColor.black))
//        }else if WrongAnswer == 0 {
//            pie.models.append(PieSliceModel(value: RightAnswer, color: UIColor.black))
//        }else{
//            pie.models = [
//                PieSliceModel(value: WrongAnswer, color: UIColor.black),
//                PieSliceModel(value: RightAnswer, color: UIColor.clear)
//            ]
      //  }
    }
    
    
    @IBAction func shareAction(_ sender: Any){
        // text to share
        let text:String = "Love score of: \(MyName.uppercased()) ❤️ \(partnersName.uppercased()) is \(total). Download to see how much you love. https://apps.apple.com/us/developer/junaid-mukadam/id1365586675"
        
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
        
        if currentCount! >= 75 {
            if currentCount == 75 ||  currentCount == 80 ||  currentCount == 85 ||  currentCount == 90 ||  currentCount == 95 {
            Sound.play(file: "firework.mp3")
            }
            SwiftFireworks.sharedInstance.showFirework(inView: view, andPosition: CGPoint( x:CGFloat( arc4random_uniform( UInt32( floor( self.view.frame.width  ) ) ) ),
                                                                                           y:CGFloat( arc4random_uniform( UInt32( floor( self.view.frame.height ) ) ) )
            ))
            let a:UIImage = countDisply.currentBackgroundImage!.withRenderingMode(.alwaysTemplate)
            
            countDisply.setBackgroundImage(a, for: .normal)
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
        
        
        if currentCount == maxCount {
             Sound.play(file: "clap.wav")
            //share.isHidden = false
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
