//
//  HeaderTableViewCell.swift
//  Emir Beytekin
//
//  Created by Emir Beytekin on 26.10.2017.
//  Copyright © 2017 Emir Beytekin. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var userName: GlitchLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userAvatar.layer.cornerRadius = userAvatar.frame.size.height / 2.0
        userAvatar.layer.borderWidth = 2
        userAvatar.layer.masksToBounds = true
        userAvatar.layer.borderColor = UIColor.white.cgColor
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
