//
//  SkillsTableViewCell.swift
//  Emir Beytekin
//
//  Created by Emir Beytekin on 26.10.2017.
//  Copyright © 2017 Emir Beytekin. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {

    @IBOutlet weak var skillSpacer: NSLayoutConstraint!
    @IBOutlet weak var skillVal: UILabel!
    @IBOutlet weak var skillName: UILabel!
    @IBOutlet weak var backTube: UIView!
    @IBOutlet weak var frontTube: UIView!
    @IBOutlet weak var frontWidth: NSLayoutConstraint!
    @IBOutlet weak var barConst: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.frontTube.layer.cornerRadius = 10
        self.backTube.layer.cornerRadius = 10
        self.addShadow()
        
        
    }
    func addShadow() {
        self.backTube.layer.shadowColor = UIColor(hue: 143/360, saturation: 95/100, brightness: 96/100, alpha: 1.0).cgColor
        self.backTube.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.backTube.layer.shadowOpacity = 0.6
        self.backTube.layer.shadowRadius = 5.0
        self.backTube.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
