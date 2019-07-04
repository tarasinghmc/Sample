//
//  PieSlice.swift
//  DonutChart
//
//  Created by Tara Singh M C on 03/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

public struct PieSlice: Hashable {
    public let view: PieSliceLayer
    public internal(set) var data: PieSliceData
    
    public init(data: PieSliceData, view: PieSliceLayer) {
        self.data = data
        self.view = view
    }
    
    public var hashValue: Int {
        return data.id
    }
    
}

public func ==(slice1: PieSlice, slice2: PieSlice) -> Bool {
    return slice1.data.id == slice2.data.id
}

