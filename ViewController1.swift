//
//  ViewController.swift
//  LineChartDemo
//
//  Created by Tara Singh M C on 10/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lineChart: LineChart!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        lineChart.x.grid.count = 5
        lineChart.y.grid.count = 1
        lineChart.drawGraph()

    }

}

