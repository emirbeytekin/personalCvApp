//
//  ExperienceTableViewCell.swift
//  Emir Beytekin
//
//  Created by Emir Beytekin on 27.10.2017.
//  Copyright © 2017 Emir Beytekin. All rights reserved.
//

import UIKit

class ExperienceTableViewCell: UITableViewCell {

    @IBOutlet weak var expName: UILabel!
    @IBOutlet weak var expStart: UILabel!
    @IBOutlet weak var expEnd: UILabel!
    @IBOutlet weak var expStatus: UIImageView!
    @IBOutlet weak var expPos: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
