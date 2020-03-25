//
//  PlayerView.swift
//  Love Test New
//
//  Created by Junaid Mukadam on 23/03/20.
//  Copyright © 2020 Saif Mukadam. All rights reserved.
//

import Foundation
import SwiftGifOrigin
import UIKit

class PlayerView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var answeris = ""
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return optionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Options", for: indexPath) as! Options
        cell.button.setTitle("  "+optionArray[indexPath.row]+"  ", for: .normal)
        cell.button.addTarget(self, action: #selector(selecto(sender:)), for: .touchUpInside)
        return cell
        
    }
    
    @objc func selecto(sender:UIButton) {
        selectedAnswer = sender.titleLabel!.text!
        answeris = sender.titleLabel!.text!
        NotificationCenter.default.post(name: NSNotification.Name("Answerd"), object: nil)
    }
    
    func answerIS()->String {
        return answeris
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: (collectionViewWidth/3)-10, height: (collectionViewWidth/3)-10)
    }
    
    func updateQuetion(tex:String){
        question.text = tex
    }
    
    func updateSide(tex:String){
        side.text = tex
    }
    
    func updateoptionArray(array:[String]){
        optionArray = array
    }
    
    
    func enableWait(trueFlase:Bool = false){
        if trueFlase {
            question.removeFromSuperview()
            side.removeFromSuperview()
            questionCollection.removeFromSuperview()
            self.addSubview(wait)
            wait.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                wait.topAnchor.constraint(equalTo:self.topAnchor,constant: 100),
                wait.leadingAnchor.constraint(equalTo:self.leadingAnchor,constant: 100),
                wait.trailingAnchor.constraint(equalTo:self.trailingAnchor,constant: -100),
                wait.bottomAnchor.constraint(equalTo:self.bottomAnchor,constant: -100)
            ])
        }else{
            wait.removeFromSuperview()
            addCusatomView()
            
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        let nib = UINib(nibName: "Options", bundle: nil)
        questionCollection.register(nib, forCellWithReuseIdentifier: "Options")
        addCusatomView()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addCusatomView(){
        self.addSubview(side)
        side.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            side.topAnchor.constraint(equalTo:self.topAnchor),
            side.leadingAnchor.constraint(equalTo:self.leadingAnchor),
            side.heightAnchor.constraint(equalToConstant: 25),
            side.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        self.addSubview(question)
        question.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            question.topAnchor.constraint(equalTo:self.topAnchor,constant: 11),
            question.leadingAnchor.constraint(equalTo:self.leadingAnchor,constant: 5),
            question.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5),
            question.heightAnchor.constraint(equalTo:self.heightAnchor, multiplier: 0.26)
        ])
        
        self.addSubview(questionCollection)
        questionCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionCollection.topAnchor.constraint(equalTo:question.bottomAnchor,constant: 10),
            questionCollection.leadingAnchor.constraint(equalTo:self.leadingAnchor,constant: 5),
            questionCollection.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5),
            questionCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10)
        ])
        questionCollection.delegate  = self
        questionCollection.dataSource = self
        questionCollection.reloadData()
    }
    
    lazy var questionCollection:UICollectionView = {
        let que:UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        que.allowsMultipleSelection = false
        layout.scrollDirection = .vertical
        //layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 5)
        //layout.itemSize = CGSize(width: self.bounds.width/4, height: self.bounds.height/4)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        que.collectionViewLayout = layout
        que.showsVerticalScrollIndicator = false
        que.allowsSelection = true
        que.delegate = self
        que.dataSource = self
        que.backgroundColor = UIColor.clear
        return que
    }()
    
    var optionArray = [String]()
    
    lazy var question:UILabel = {
        let but = UILabel()
        but.adjustsFontSizeToFitWidth = true
        but.textColor = .white
        but.minimumScaleFactor = 0.5
        but.textAlignment = .center
        but.numberOfLines = 3
        but.font = UIFont(name: "GillSans-Bold", size: 21)
        but.text = "What is your partner’s favorite flavor of ice cream ?"
        return but
    }()
    
    lazy var wait:UIImageView = {
        let but = UIImageView()
        but.loadGif(name: "wait")
        but.contentMode = .scaleAspectFit
        return but
    }()
    
    lazy var side:UILabel = {
        let but = UILabel()
        but.adjustsFontSizeToFitWidth = true
        but.textColor = .black
        but.minimumScaleFactor = 0.25
        but.textAlignment = .left
        but.numberOfLines = 3
        but.font = UIFont(name: "GillSans-Bold", size: 13)
        but.text = "Saif's Side"
        return but
    }()
    
    lazy var option1:UIButton = {
        let but = UIButton()
        but.titleLabel?.adjustsFontSizeToFitWidth = true
        but.titleLabel?.minimumScaleFactor = 0.5
        but.titleLabel?.font = UIFont(name: "Gill Sans", size: 18)
        but.setBackgroundImage(#imageLiteral(resourceName: "valentines-heart-2"), for: .normal)
        but.setTitle("Vanilla", for: .normal)
        return but
    }()
    
    
    lazy var option2:UIButton = {
        let but = UIButton()
        but.titleLabel?.adjustsFontSizeToFitWidth = true
        but.titleLabel?.minimumScaleFactor = 0.5
        but.titleLabel?.font = UIFont(name: "Gill Sans", size: 18)
        but.setBackgroundImage(#imageLiteral(resourceName: "valentines-heart-2"), for: .normal)
        but.setTitle("Chocolate", for: .normal)
        return but
    }()
    
    lazy var option3:UIButton = {
        let but = UIButton()
        but.titleLabel?.adjustsFontSizeToFitWidth = true
        but.titleLabel?.minimumScaleFactor = 0.5
        but.titleLabel?.font = UIFont(name: "Gill Sans", size: 18)
        but.setBackgroundImage(#imageLiteral(resourceName: "valentines-heart-2"), for: .normal)
        but.setTitle("Strawberry", for: .normal)
        return but
    }()
    
    
    lazy var option4:UIButton = {
        let but = UIButton()
        but.titleLabel?.adjustsFontSizeToFitWidth = true
        but.titleLabel?.minimumScaleFactor = 0.5
        but.titleLabel?.font = UIFont(name: "Gill Sans", size: 18)
        but.setBackgroundImage(#imageLiteral(resourceName: "valentines-heart-2"), for: .normal)
        but.setTitle("Lichi", for: .normal)
        return but
    }()
    
    lazy var option5:UIButton = {
        let but = UIButton()
        but.titleLabel?.adjustsFontSizeToFitWidth = true
        but.titleLabel?.minimumScaleFactor = 0.5
        but.titleLabel?.font = UIFont(name: "Gill Sans", size: 18)
        but.setBackgroundImage(#imageLiteral(resourceName: "valentines-heart-2"), for: .normal)
        but.setTitle("Mango", for: .normal)
        return but
    }()
    
    lazy var option6:UIButton = {
        let but = UIButton()
        but.titleLabel?.adjustsFontSizeToFitWidth = true
        but.titleLabel?.minimumScaleFactor = 0.5
        but.titleLabel?.font = UIFont(name: "Gill Sans", size: 18)
        but.setBackgroundImage(#imageLiteral(resourceName: "valentines-heart-2"), for: .normal)
        but.setTitle("Other", for: .normal)
        return but
    }()
    
}


//let stac1 = UIStackView(arrangedSubviews: [option1,option2,option3])
//stac1.axis =  .horizontal
//stac1.distribution = .fillEqually
//stac1.alignment = .center
//stac1.spacing = 20
//self.addSubview(stac1)
//stac1.translatesAutoresizingMaskIntoConstraints = false
//NSLayoutConstraint.activate([
//    stac1.topAnchor.constraint(equalTo:question.bottomAnchor,constant: 15),
//    stac1.leadingAnchor.constraint(equalTo:self.leadingAnchor,constant: 10),
//    stac1.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
//    stac1.heightAnchor.constraint(equalTo:self.heightAnchor, multiplier: 0.26)
//])
//
//let stac2 = UIStackView(arrangedSubviews: [option4,option5,option6])
//stac2.axis =  .horizontal
//stac2.distribution = .fillEqually
//stac2.alignment = .center
//stac2.spacing = 20
//self.addSubview(stac2)
//stac2.translatesAutoresizingMaskIntoConstraints = false
//NSLayoutConstraint.activate([
//    stac2.topAnchor.constraint(equalTo:stac1.bottomAnchor,constant: 5),
//    stac2.leadingAnchor.constraint(equalTo:self.leadingAnchor,constant: 10),
//    stac2.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10),
//    stac2.heightAnchor.constraint(equalTo:self.heightAnchor, multiplier: 0.26)
//])
