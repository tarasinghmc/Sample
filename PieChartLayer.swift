//
//  PieChartLayer.swift
//  DonutChart
//
//  Created by Tara Singh M C on 03/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

public protocol PieChartLayer: PieChartDelegate {
    var chart: PieChart? {get set}
    func onEndAnimation(slice: PieSlice)
    func addItems(slice: PieSlice)
    func clear()
}
