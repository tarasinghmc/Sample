//
//  AddToSiriContentTableViewCell.swift
//  SiriShortcutDemo
//
//  Created by Tara Singh M C on 25/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

class AddToSiriContentTableViewCell: UITableViewCell {
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var selectImageView: UIImageView!
    @IBAction func moreButtonTapped(_ sender: Any) {
    }
    @IBOutlet weak var valueLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
