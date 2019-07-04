//
//  PieChartLabelSettings.swift
//  DonutChart
//
//  Created by Tara Singh M C on 04/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

public class PieChartLabelSettings {
    
    public var textColor: UIColor = UIColor.black
    public var bgColor: UIColor = UIColor.clear
    public var font: UIFont = UIFont.boldSystemFont(ofSize: 20)
    
    public var textGenerator: (PieSlice) -> String = {"\($0.data.model.name)"}
    
    // Optional custom label - when this is set presentations settings (textColor, etc.) are ignored
    public var labelGenerator: ((PieSlice) -> UILabel)?
}
