//
//  AddToSiriPriorityView.swift
//  SiriShortcutDemo
//
//  Created by Tara Singh M C on 24/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import Foundation
import UIKit

struct AlertPriority {
    enum FlagType {
        case red
        case amber
        case yellow
    }
    var type: FlagType
    var title: String
    var isSelected: Bool
    init(type: FlagType, title: String, isSelected: Bool) {
        self.type = type
        self.title = title
        self.isSelected = isSelected
    }
}

protocol AddToSiriPriorityViewDelegate: class {
    func addToSiriPriorityView(_ view:AddToSiriPriorityView, didSelectPriority priority: AlertPriority)
     func addToSiriPriorityView(_ view:AddToSiriPriorityView, didDeselectPriority priority: AlertPriority)
}
@IBDesignable class AddToSiriPriorityView: UIView {
    /// Corner Radius
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }
        set {
            self.layer.cornerRadius = CGFloat(newValue)
            self.layer.masksToBounds = true
        }
    }
    // Tableview
    private let tableView = UITableView()
    public weak var delegate: AddToSiriPriorityViewDelegate?
    private var dataList: [AlertPriority]!
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        dataList = [AlertPriority(type: .red, title: "Red Alert", isSelected: false),
                   AlertPriority(type: .amber, title: "Amber Alert", isSelected: false),
                   AlertPriority(type: .yellow, title: "Yellow Alert", isSelected: false)]
        
        // TableView
        tableView.tableFooterView = UIView(frame: .zero)
//        tableView.register(UINib.init(nibName: "AddToSiriPriorityTableViewCell", bundle: nil), forCellReuseIdentifier: "AddToSiriPriorityTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AddToSiriPriorityTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.reloadData()
        let space: CGFloat = 0
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: space),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: space),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: space),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: space)
            ])
    }
    
    public func unselectAllPriority() {
        dataList = [AlertPriority(type: .red, title: "Red Alert", isSelected: false),
                    AlertPriority(type: .amber, title: "Amber Alert", isSelected: false),
                    AlertPriority(type: .yellow, title: "Yellow Alert", isSelected: false)]
        tableView.reloadData()
    }
}

extension AddToSiriPriorityView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddToSiriPriorityTableViewCell", for: indexPath)
        cell.textLabel?.text = data.title
        cell.accessoryType = data.isSelected == true ? .checkmark : .none
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var data = dataList[indexPath.row]
        data.isSelected = !data.isSelected
        dataList[indexPath.row] = data
        tableView.reloadData()
        if data.isSelected {
            delegate?.addToSiriPriorityView(self, didSelectPriority: data)
        } else {
            delegate?.addToSiriPriorityView(self, didDeselectPriority: data)
        }
    }
    
}
