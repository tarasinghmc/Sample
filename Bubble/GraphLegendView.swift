//
//  GraphLegendView.swift
//  Bubble
//
//  Created by Tara Singh M C on 09/06/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit
struct Arc {
    var name: String
    var value: Int
    var color: UIColor
}

class LegendItem: UIControl {
    private var boxView = UIView()
    private var nameLabel = UILabel()
    public var arc: Arc!
    private var button = UIButton()
    
    init(frame: CGRect, arc: Arc) {
        super.init(frame: frame)
        self.arc = arc
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(sender:)
            ), for: .touchUpInside)
        self.addSubview(button)
        
        let space: CGFloat = 8.0
        
        let leadingAnchor = button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space)
        let topAnchor = button.topAnchor.constraint(equalTo: self.topAnchor, constant: space)
        let bottomAnchor = button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space)
        let trailingAnchor = button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -space)
        
        boxView.layer.cornerRadius = 2.0
        boxView.backgroundColor = arc.color
        boxView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(boxView)
        
        
        let boxcenterYAnchor = boxView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let boxLeadingAnchor = boxView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space)
        let boxHeightAnchor = boxView.heightAnchor.constraint(equalToConstant: 16.0)
        let boxWidthAnchor = boxView.widthAnchor.constraint(equalToConstant: 16.0)
        
        nameLabel.text = "\(arc.value) - \(arc.name)"
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(nameLabel)
        
        let nameLeadingAnchor = nameLabel.leadingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: space)
        let nameTopAnchor = nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0.0)
        let nameBottomAnchor = nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.0)
        let nameTrailingAnchor = nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -space)
        
        NSLayoutConstraint.activate([boxcenterYAnchor,boxLeadingAnchor,boxHeightAnchor,boxWidthAnchor, nameLeadingAnchor, nameTopAnchor, nameBottomAnchor, nameTrailingAnchor, leadingAnchor, topAnchor, bottomAnchor, trailingAnchor])
        
    }
    @objc func buttonTapped(sender: UIButton) {
        sendActions(for: .valueChanged)
    }
    //    override init(frame: CGRect) {
    //        super.init(frame: frame)
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        super.init(coder: aDecoder)
    //    }
    
    
    
}
protocol GraphLegendViewDelegate: class {
    func graphLegendView(_ graphLegendView: GraphLegendView, didSelectArc arc: Arc)
}
class GraphLegendView: UIView {
    var arcs:[Arc]? {
        didSet {
            configureView()
        }
    }
    
    var delegate: GraphLegendViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureView() {
        self.backgroundColor = UIColor.groupTableViewBackground
        
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        guard let arcs = self.arcs else {
            return
        }
        
        //
        var currentArcs = [Arc]()
        var lastStackView: UIStackView?
        
        for (index, arc) in arcs.enumerated() {
            
            currentArcs.append(arc)
            if currentArcs.count == 3 {
 
                let stackView = stackViewForArcs(currentArcs)
                if lastStackView == nil {
                    stackView.translatesAutoresizingMaskIntoConstraints = false
                    self.addSubview(stackView)
                   
                    let topAnchor = stackView.topAnchor.constraint(equalTo: self.topAnchor)
                   let leadingAnchor = stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
                    let trailingAnchor = stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
                  
                    let height = stackView.heightAnchor.constraint(equalToConstant: 40)
                    NSLayoutConstraint.activate([topAnchor, leadingAnchor, trailingAnchor, height])
                }  else {
                    
                    stackView.translatesAutoresizingMaskIntoConstraints = false
                    self.addSubview(stackView)
                    
                    let topAnchor = stackView.topAnchor.constraint(equalTo: lastStackView!.bottomAnchor)
                    let leadingAnchor = stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
                    let trailingAnchor = stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
                    
                    let height = stackView.heightAnchor.constraint(equalToConstant: 40)
                    NSLayoutConstraint.activate([topAnchor, leadingAnchor, trailingAnchor, height])
                }
                
                lastStackView = stackView
                currentArcs.removeAll()
            } else if index == (arcs.count - 1) {

                let stackView = lastRowViewForArcs(currentArcs)

                if lastStackView == nil {
 stackView.translatesAutoresizingMaskIntoConstraints = false
                    self.addSubview(stackView)
                    
                    let topAnchor = stackView.topAnchor.constraint(equalTo: self.topAnchor)
                    let leadingAnchor = stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
                    let trailingAnchor = stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
                    
                    let height = stackView.heightAnchor.constraint(equalToConstant: 40)
                    NSLayoutConstraint.activate([topAnchor, leadingAnchor, trailingAnchor, height])
                } else {
                    stackView.translatesAutoresizingMaskIntoConstraints = false
                    self.addSubview(stackView)
                    
                    let topAnchor = stackView.topAnchor.constraint(equalTo: lastStackView!.bottomAnchor)
                    let leadingAnchor = stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
                    let trailingAnchor = stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
                    
                    let height = stackView.heightAnchor.constraint(equalToConstant: 40)
                    NSLayoutConstraint.activate([topAnchor, leadingAnchor,trailingAnchor, height])
                }

                currentArcs.removeAll()
            }
            

        }
        
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    @objc func legendItemTapped(_ sender: LegendItem) {
        print(sender.arc.name)
        delegate?.graphLegendView(self, didSelectArc: sender.arc)
    }
    
    func stackViewForArcs(_ arcs: [Arc]) -> UIStackView {
  
            var subViews = [LegendItem]()
            for arc in arcs {
                let legendItem = LegendItem(frame: .zero, arc: arc)
                legendItem.addTarget(self, action: #selector(legendItemTapped(_:)), for: .valueChanged)
                 legendItem.translatesAutoresizingMaskIntoConstraints = false
                subViews.append(legendItem)
            }
            let stackView = UIStackView(arrangedSubviews: subViews)
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.alignment = .center
            return stackView
       
    }
    
    func lastRowViewForArcs(_ arcs: [Arc]) -> UIView {

            let mainView = UIView()
        var lastLegendItem: LegendItem?
        
            for arc in arcs {
                let legendItem = LegendItem(frame: .zero, arc: arc)
                legendItem.addTarget(self, action: #selector(legendItemTapped(_:)), for: .valueChanged)
                legendItem.translatesAutoresizingMaskIntoConstraints = false

                mainView.addSubview(legendItem)
                
                let topAnchor = legendItem.topAnchor.constraint(equalTo: mainView.topAnchor)
                let leadingAnchor: NSLayoutConstraint!
                
                if lastLegendItem == nil {
                  leadingAnchor =  legendItem.leadingAnchor.constraint(equalTo: mainView.leadingAnchor)
                } else {
                   leadingAnchor =  legendItem.leadingAnchor.constraint(equalTo: lastLegendItem!.trailingAnchor)
                }
           
                let bottomAnchor = legendItem.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
                
                let widthAnchor = legendItem.widthAnchor.constraint(equalToConstant: self.bounds.maxX/3)
                
                NSLayoutConstraint.activate([topAnchor, leadingAnchor, widthAnchor, bottomAnchor])
                
                lastLegendItem = legendItem
            }
        
            return mainView
            
        
    }
}
