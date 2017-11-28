//
//  MyWorksCollectionViewCell.swift
//  Emir Beytekin
//
//  Created by Emir Beytekin on 26.10.2017.
//  Copyright © 2017 Emir Beytekin. All rights reserved.
//

import UIKit

class MyWorksCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var worksImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        worksImage?.layer.cornerRadius = (worksImage?.frame.size.height)!/2
        worksImage?.layer.borderColor = UIColor.yellow.cgColor
        worksImage?.layer.borderWidth = 0
        worksImage.layer.masksToBounds = true
        backView.layer.cornerRadius = (worksImage?.frame.size.height)!/2
        backView.layer.masksToBounds = true
//        worksImage?.layer.shadowColor = UIColor(hue: 143/360, saturation: 95/100, brightness: 96/100, alpha: 1.0).cgColor
//        worksImage?.layer.shadowOffset = CGSize(width: 0, height: 3)
//        worksImage?.layer.shadowOpacity = 0.6
//        worksImage?.layer.shadowRadius = 5.0
//        worksImage?.layer.masksToBounds = true
//        worksImage?.layer.shadowPath = UIBezierPath(roundedRect: worksImage.bounds, cornerRadius: 10).cgPath
        
        // Initialization code
    }
    
    func addShadow() {
        
        
    }

}
