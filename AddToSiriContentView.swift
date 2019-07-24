//
//  AddToSiriContentView.swift
//  SiriShortcutDemo
//
//  Created by Tara Singh M C on 24/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

import UIKit

fileprivate struct AddToSiriContentViewRow {
    enum RowType {
        case rule
        case country
        case lob
        case sublob
        case partnerOnly
    }
    var type: RowType
    var selectedValues: [String]?
    var title: String
    var isExpandableRow: Bool
    var isAllValuesSelected: Bool {
        didSet {
            if isAllValuesSelected == true {
                selectedValues = nil
            }
        }
    }
    var isSelected: Bool
    init(type: RowType, title: String, isExpandableRow: Bool = true, isAllValuesSelected: Bool = true, isSelected: Bool = true) {
        self.type = type
        self.title = title
        self.isAllValuesSelected = isAllValuesSelected
        self.isSelected = isSelected
        self.isExpandableRow = isExpandableRow
    }
}

protocol AddToSiriContentViewDelegate: class {
    func hideAddToSiriContentView(_ view:AddToSiriContentView)
}

@IBDesignable class AddToSiriContentView: UIView {
    
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
    
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    public weak var delegate: AddToSiriContentViewDelegate?

    private var dataList = [AddToSiriContentViewRow]()
    // Tableview
    private let tableView = UITableView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addDefaultData()
        let titleView = createTitleView()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            titleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            titleView.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        // TableView
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.register(UINib.init(nibName: "AddToSiriContentTableViewCell", bundle: nil), forCellReuseIdentifier: "AddToSiriContentTableViewCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.reloadData()
        let space: CGFloat = 0
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: space),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: space),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: space),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: space)
            ])
    }
    
    private func createTitleView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
            ])
        
        let cancelButton = UIButton()
        cancelButton.layer.cornerRadius = 10
        cancelButton.backgroundColor = .red
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            cancelButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             cancelButton.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 8),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            cancelButton.heightAnchor.constraint(equalToConstant: 30),
            cancelButton.widthAnchor.constraint(equalToConstant: 30)
            ])
        
        return view
    }
    
    @objc func cancelButtonTapped(_ sender: UIButton) {
        addDefaultData() // Reset data to default
        delegate?.hideAddToSiriContentView(self)
    }
    
    public func addDefaultData() {
        dataList.removeAll()
        // rule
        let ruleRow = AddToSiriContentViewRow(type: .rule, title: "Rule")
        dataList.append(ruleRow)
        // Country
        let countryRow = AddToSiriContentViewRow(type: .country, title: "Country")
        dataList.append(countryRow)
        // Partner
        let partnerOnlyRow = AddToSiriContentViewRow(type: .partnerOnly, title: "Partner Only", isExpandableRow: false)
        
        dataList.append(partnerOnlyRow)
        // Lob
        let lobRow = AddToSiriContentViewRow(type: .lob, title: "Lob")
        dataList.append(lobRow)
        // Sublob
        let sublobRow = AddToSiriContentViewRow(type: .sublob, title: "Sublob")
        dataList.append(sublobRow)
        tableView.reloadData()
    }
    public func removeAllData() {
        dataList.removeAll()
        tableView.reloadData()
    }
}

extension AddToSiriContentView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddToSiriContentTableViewCell", for: indexPath) as? AddToSiriContentTableViewCell
        cell?.titleLabel.text = data.title
       
        cell?.selectImageView.backgroundColor = data.isSelected == true ? UIColor.red : UIColor.green
        if data.isExpandableRow {
            cell?.moreButton.isHidden = false
            if data.isAllValuesSelected {
                cell?.valueLabel.text = "All"
            } else {
                cell?.valueLabel.text = "\(data.selectedValues?.count ?? 0) \(data.title.lowercased())"
            }
        } else {
            cell?.moreButton.isHidden = true
            cell?.valueLabel.text = nil
        }
        
        
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var data = dataList[indexPath.row]
        data.isSelected = !data.isSelected
        dataList[indexPath.row] = data
        tableView.reloadData()
    }
    
}
