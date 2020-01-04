//
//  TableViewCell.swift
//  DotAnimation
//
//  Created by Tara Singh M C on 04/01/20.
//  Copyright © 2020 Tara Singh. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var dotsView: Dots!
    var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bubbleView.backgroundColor = UIColor.opaqueSeparator
        self.bubbleView.layer.cornerRadius = 6.0
        self.bubbleView.layer.masksToBounds = true
        
        self.profileView.layer.cornerRadius = 30.0/2
        self.profileView.layer.masksToBounds = true
        
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.preferredFont(forTextStyle: .body)
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.text = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setAnimation(_ isTimerRequired: Bool) {
        self.dotsView.isHidden = false
        dotsView.animationStart()
        if isTimerRequired {
           timer = Timer.scheduledTimer(timeInterval: Double(4) * 1.2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
        }
        
    }
    
    @objc func runTimedCode() {
        print("Do something")
        DispatchQueue.main.async {
            self.dotsView.invalidateAnimation()
            self.dotsView.isHidden = true
            self.timer?.invalidate()
            self.messageLabel.text = "Hi! I am Aana. How i can help you?"
        }
    }
    
}
