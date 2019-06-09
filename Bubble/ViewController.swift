//
//  ViewController.swift
//  Bubble
//
//  Created by Tara Singh M C on 05/06/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit
struct Section {
    var items:[Arc]
}
class ViewController: UIViewController {
    @IBOutlet weak var collectionview: UICollectionView!
    
    @IBOutlet weak var bubbleView: BubbleView!
    var sections:[Section]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bubbleView.backgroundColor = .yellow
        bubbleView.isHidden = true
        sections = [Section]()
        let arc1 = Arc.init(name: "iPhone", value: 11, color: .green)
        let arc2 = Arc.init(name: "iPad", value: 1100, color: .red)
        let arc3 = Arc.init(name: "Watch", value: 01, color: .blue)
        let arc4 = Arc.init(name: "India", value: 51, color: .purple)
        let arc5 = Arc.init(name: "Austrail", value: 501, color: .orange)

        let section1 = Section(items: [arc1])
        sections.append(section1)
        
        let section2 = Section(items: [arc1, arc2, arc3, arc4, arc5, arc3, arc4, arc5])
        
     
        
        sections.append(section2)
    
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
//        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        collectionview.collectionViewLayout = layout
        collectionview.delegate = self
        collectionview.dataSource = self
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "tempcell")
        collectionview.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "tempHeaderCell")
        collectionview.register(UINib(nibName: "GraphCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GraphCollectionViewCell")
        collectionview.register(UINib(nibName: "FooterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterCollectionReusableView")
    }


}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let sectionObj = sections[indexPath.section]
            let arc = sectionObj.items[indexPath.row]
            let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "tempcell", for: indexPath)
            cell.backgroundColor = arc.color
            return cell
        } else {
            let sectionObj = sections[indexPath.section]
            let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "GraphCollectionViewCell", for: indexPath) as? GraphCollectionViewCell
            
        cell?.legendView.arcs = sectionObj.items
            cell?.legendView.delegate = self
            return cell!
        }
     
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
                return CGSize(width: collectionView.frame.size.width, height: 100)
        } else {
            let sectionObj = sections[indexPath.section]

            var count: Double = Double(sectionObj.items.count/3)
            if sectionObj.items.count % 3 != 0 {
                count += 1
            }
            print(count)
            
              return CGSize(width: collectionView.frame.size.width, height: CGFloat(238.0 + (count * 40.0) + 8.0))
            /*let items = sections[indexPath.section].items

            if indexPath.row == 0  {
                return CGSize(width: collectionView.frame.size.width, height: 200)
            } /*else if indexPath.row == (items.count-1) {
                return CGSize(width: collectionView.frame.size.width, height: 50)
            } */else {
                 return CGSize(width: (collectionView.frame.size.width/3)-30, height: 50)
            }*/
        }
    
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var reusableView : UICollectionReusableView? = nil
        
        switch kind {
        case  UICollectionView.elementKindSectionFooter:
            // Create Footer
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "FooterCollectionReusableView", for: indexPath)
            footerView.backgroundColor = UIColor.lightGray
            reusableView = footerView
        case UICollectionView.elementKindSectionHeader:
            // Create Header
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "tempHeaderCell", for: indexPath)
            headerView.backgroundColor = UIColor.gray

            reusableView = headerView
        default:
            print("Unknown")
        }
      
        return reusableView!
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
           return .zero
        } else {
            return CGSize(width: collectionView.frame.width, height: 50)
        }
    }
    
   
}

extension ViewController: GraphLegendViewDelegate {
    func graphLegendView(_ graphLegendView: GraphLegendView, didSelectArc arc: Arc) {
        print("ViewController : ",arc.name)
    }
    
    
}
