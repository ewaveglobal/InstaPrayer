//
//  TableViewCell.swift
//  InstaPrayer
//
//  Created by Aviram Shakiv on 26/03/2017.
//  Copyright © 2017 Aviram Shakiv. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var ivCheck: UIImageView!
    @IBOutlet weak var tfDetails: PaylotTextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
