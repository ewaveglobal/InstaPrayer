//
//  checkboxCell.swift
//  InstaPrayer
//
//  Created by Aviram Shakiv on 26/03/2017.
//  Copyright © 2017 Aviram Shakiv. All rights reserved.
//

import UIKit

class checkboxCell: UITableViewCell {
    @IBOutlet weak var btnCheckbox: UIButton!
    @IBOutlet weak var btnTerms: PaylotButton!
    @IBOutlet weak var btnContinue: PaylotButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
