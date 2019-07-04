//
//  PieChartDelegate.swift
//  DonutChart
//
//  Created by Tara Singh M C on 03/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

public protocol PieChartDelegate: class {
    
    func onGenerateSlice(slice: PieSlice)
    
    func onStartAnimation(slice: PieSlice)
    
    func onEndAnimation(slice: PieSlice)
    
    func onSelected(slice: PieSlice, selected: Bool)
}

extension PieChartDelegate {
    
    public func onGenerateSlice(slice: PieSlice) {}
    
    public func onStartAnimation(slice: PieSlice) {}
    
    public func onEndAnimation(slice: PieSlice) {}
}
