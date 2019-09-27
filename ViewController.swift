//
//  ViewController.swift
//  TDApp
//
//  Created by Tara Singh M C on 26/09/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var dataList = ["A", "B", "C", "D", "E"]
    var selectedValues:[String]? {
        didSet {
            if self.selectedValues?.count ?? 0 == dataList.count {
                selectOn.text = "Clear All"
            } else {
                selectOn.text = "Select All"
            }
        }
    }
    
    let selectOn = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.register(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoTableViewCell")
       tableview.delegate = self
       tableview.dataSource = self
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = UITableView.automaticDimension
        selectedValues = dataList
        
        let view = UIView(frame: .zero)
        view.addSubview(selectOn)
        selectOn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([selectOn.topAnchor.constraint(equalTo: view.topAnchor
                                                                   ),selectOn.leadingAnchor.constraint(equalTo: view.leadingAnchor),selectOn.trailingAnchor.constraint(equalTo: view.trailingAnchor),selectOn.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        let navigt = UIBarButtonItem(customView: view)
        
        self.navigationItem.rightBarButtonItem = navigt
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! InfoTableViewCell
        cell.titleLabel.text = dataList[indexPath.row]
        if selectedValues?.contains(dataList[indexPath.row]) ?? false {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard var selectedValues = self.selectedValues else {
            self.selectedValues = [dataList[indexPath.row]]
            return
        }
        
        let index = selectedValues.firstIndex(where: { value in
            return dataList[indexPath.row] == value
        })
        
        if let index = index {
            selectedValues.remove(at: index)
        } else {
            selectedValues.append(dataList[indexPath.row])
        }
        
        self.selectedValues = selectedValues
        tableView.reloadData()

    }
    
 
    
}
