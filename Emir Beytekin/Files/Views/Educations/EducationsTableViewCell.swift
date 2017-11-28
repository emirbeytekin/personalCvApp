//
//  EducationsTableViewCell.swift
//  Emir Beytekin
//
//  Created by Emir Beytekin on 27.10.2017.
//  Copyright © 2017 Emir Beytekin. All rights reserved.
//

import UIKit

class EducationsTableViewCell: UITableViewCell {

    @IBOutlet weak var eduName: UILabel!
    @IBOutlet weak var eduStart: UILabel!
    @IBOutlet weak var eduEnd: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
