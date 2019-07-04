//
//  ViewController.swift
//  DonutChart
//
//  Created by Tara Singh M C on 03/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PieChartDelegate {
    @IBOutlet weak var chartView: PieChart!
    fileprivate static let alpha: CGFloat = 0.5
    let colors = [
        UIColor.yellow.withAlphaComponent(alpha),
        UIColor.green.withAlphaComponent(alpha),
        UIColor.purple.withAlphaComponent(alpha),
        UIColor.cyan.withAlphaComponent(alpha),
        UIColor.darkGray.withAlphaComponent(alpha),
        UIColor.red.withAlphaComponent(alpha),
        UIColor.magenta.withAlphaComponent(alpha),
        UIColor.orange.withAlphaComponent(alpha),
        UIColor.brown.withAlphaComponent(alpha),
        UIColor.lightGray.withAlphaComponent(alpha),
        UIColor.gray.withAlphaComponent(alpha),
        ]
    fileprivate var currentColorIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        
        chartView.layers = [createTextWithLinesLayer(), createTextWithLinesLayer()]
        chartView.delegate = self
        chartView.models = createModels() // order is important - models have to be set at the end
    }
    
    // MARK: - PieChartDelegate
    
    func onSelected(slice: PieSlice, selected: Bool) {
        print("Selected: \(selected), slice: \(slice.data.model.name)")
    }
    
    // MARK: - Models
    
    fileprivate func createModels() -> [PieSliceModel] {
        
        let models = [
            PieSliceModel(value: 2, color: colors[0], name: "Apple"),
            PieSliceModel(value: 3, color: colors[1], name: "Box"),
            PieSliceModel(value: 20, color: colors[2], name: "Cat"),
            PieSliceModel(value: 2, color: colors[3], name: "Dog"),
            PieSliceModel(value: 3, color: colors[4], name: "Egg"),
            PieSliceModel(value: 20, color: colors[5], name: "Fox")
        ]
        
        currentColorIndex = models.count
        return models
    }
    

    fileprivate func createTextWithLinesLayer() -> PieLineTextLayer {
        let lineTextLayer = PieLineTextLayer()
        var lineTextLayerSettings = PieLineTextLayerSettings()
        lineTextLayerSettings.lineColor = UIColor.lightGray
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 1
        lineTextLayerSettings.label.font = UIFont.systemFont(ofSize: 14)
        lineTextLayerSettings.label.textGenerator = {slice in
            let count = formatter.string(from: slice.data.model.value as NSNumber).map{"\($0)"} ?? ""
            return slice.data.model.name + " : " + count
        }
        
        lineTextLayer.settings = lineTextLayerSettings
        return lineTextLayer
    }
}

