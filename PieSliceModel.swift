//
//  PieSliceModel.swift
//  DonutChart
//
//  Created by Tara Singh M C on 03/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

public class PieSliceModel {
    
    public let value: Double
    public let color: UIColor
    public let name: String /// optional object to pass around e.g. to the layer's text generators
    
    public init(value: Double, color: UIColor, name: String = "") {
        self.value = value
        self.color = color
        self.name = name
    }
}
