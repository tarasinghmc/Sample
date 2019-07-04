//
//  PieLineTextLayerAnimator.swift
//  DonutChart
//
//  Created by Tara Singh M C on 04/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

public protocol PieLineTextLayerAnimator {
    
    func animate(_ layer: CALayer)
    
    func animate(_ label: UILabel)
}

