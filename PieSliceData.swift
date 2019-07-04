//
//  PieSliceData.swift
//  DonutChart
//
//  Created by Tara Singh M C on 03/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

public class PieSliceData {
    public let model: PieSliceModel
    public internal(set) var id: Int
    public internal(set) var percentage: Double
    
    public init(model: PieSliceModel, id: Int, percentage: Double) {
        self.model = model
        self.id = id
        self.percentage = percentage
    }
}
