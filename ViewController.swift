//
//  ViewController.swift
//  SiriShortcutDemo
//
//  Created by Tara Singh M C on 24/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

struct SiriIntentContent {
    var priorityAlerts = [AlertPriority]()
    
}

class ViewController: UIViewController {

    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var contentView: AddToSiriContentView!
    @IBOutlet weak var priorityView: AddToSiriPriorityView!
    
    lazy var intentContent: SiriIntentContent = {
        return SiriIntentContent()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add To Siri"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        priorityView.delegate = self
        contentView.delegate = self
       showContentView()
    }

    func showContentView() {
        if intentContent.priorityAlerts.count == 0 {
            contentView.isHidden = true
            hintLabel.isHidden = false
        } else {
            contentView.isHidden = false
            hintLabel.isHidden = true
            
            
            var titleStr = intentContent.priorityAlerts.map() {$0.title}.joined(separator: ", ")
            titleStr = titleStr.replacingOccurrences(of: " Alert", with: "").appending(" Alerts")
            contentView.title = titleStr
        }
    }

}

extension ViewController: AddToSiriPriorityViewDelegate {
    func addToSiriPriorityView(_ view: AddToSiriPriorityView, didSelectPriority priority: AlertPriority) {
        intentContent.priorityAlerts.append(priority)
        
      showContentView()
    }
    
    func addToSiriPriorityView(_ view: AddToSiriPriorityView, didDeselectPriority priority: AlertPriority) {
    
        let firstIndex = intentContent.priorityAlerts.firstIndex(where: { ap in
            if ap.type == priority.type {
                return true
            } else {
                return false
            }
        })
        
        guard let index = firstIndex else {
            return
        }
        
        intentContent.priorityAlerts.remove(at: index)
    
      showContentView()
    }
    
    
}

extension ViewController: AddToSiriContentViewDelegate {
    func hideAddToSiriContentView(_ view: AddToSiriContentView) {
        priorityView.unselectAllPriority()
        intentContent.priorityAlerts.removeAll()
        showContentView()
    }
    
    
}
