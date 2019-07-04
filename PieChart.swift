//
//  PieChartView.swift
//  DonutChart
//
//  Created by Tara Singh M C on 03/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

public class PieChart: UIView {
    public var innerRadius: CGFloat = 50
    public var outerRadius: CGFloat = 100
    public var strokeColor: UIColor = .black
    public var animationDuration: Double = 0.5
    public var selectedOffset: CGFloat = 30
    public var strokeWidth: CGFloat = 0
    public var referenceAngle: CGFloat = 0 {
        didSet {
            for layer in layers {
                layer.clear()
            }
            
            let delta = (referenceAngle - oldValue).degreesToRadians
            for slice in slices {
                slice.view.angles = (slice.view.startAngle + delta, slice.view.endAngle + delta)
            }
            
            for slice in slices {
                slice.view.present(animated: false)
            }        }
    }
    
    public var animated: Bool {
        return animationDuration > 0
    }
    
    public fileprivate(set) var container: CALayer = CALayer()
    public fileprivate(set) var slices: [PieSlice] = []
    public var models: [PieSliceModel] = [] {
        didSet {
            if oldValue.isEmpty {
                slices = generateSlices(models)
                showSlices()
            }        }
    }
    public weak var delegate: PieChartDelegate?
    public var layers: [PieChartLayer] = [] {
        didSet {
            for layer in layers {
                layer.chart = self
            }
        }
    }
    public var totalValue:Double {
        return models.reduce(0){$0 + $1.value}
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        layer.addSublayer(container)
        container.frame = bounds
    }
    
    fileprivate func generateSlices(_ models: [PieSliceModel]) -> [PieSlice] {
        var slices: [PieSlice] = []
        var lastEndAngle: CGFloat = 0
        
        for (index, model) in models.enumerated() {
            let (newEndAngle, slice) = generateSlice(model: model, index: index, lastEndAngle: lastEndAngle, totalValue: totalValue)
            slices.append(slice)
            
            lastEndAngle = newEndAngle
        }
        
        return slices
    }
    
    fileprivate func generateSlice(model: PieSliceModel, index: Int, lastEndAngle: CGFloat, totalValue: Double) -> (CGFloat, PieSlice) {
        let percentage = 1 / (totalValue / model.value)
        let angle = (Double.pi * 2) * percentage
        let newEndAngle = lastEndAngle + CGFloat(angle)
        
        let data = PieSliceData(model: model, id: index, percentage: percentage)
        let slice = PieSlice(data: data, view: PieSliceLayer(color: model.color, startAngle: lastEndAngle, endAngle: newEndAngle, animDelay: 0, center: bounds.center))
        
        slice.view.frame = bounds
        
        slice.view.sliceData = data
        
        slice.view.innerRadius = innerRadius
        slice.view.outerRadius = outerRadius
        slice.view.selectedOffset = selectedOffset
        slice.view.animDuration = animationDuration
        slice.view.strokeColor = strokeColor
        slice.view.strokeWidth = strokeWidth
        slice.view.referenceAngle = referenceAngle.degreesToRadians
        
        slice.view.sliceDelegate = self
        
        self.delegate?.onGenerateSlice(slice: slice)
        
        return (newEndAngle, slice)
    }
    
    fileprivate func showSlices() {
        for slice in slices {
            container.addSublayer(slice.view)
            slice.view.rotate(angle: slice.view.referenceAngle)
            slice.view.present(animated: animated)
        }
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let point = touch.location(in: self)
            
            if let slice = (slices.filter{$0.view.contains(point)}).first {
                slice.view.selected = !slice.view.selected
            }
        }
    }
    
    public func removeSlices() {
        for slice in slices {
            slice.view.removeFromSuperlayer()
        }
        slices = []
    }
    
    public func clear() {
        for layer in layers {
            layer.clear()
        }
        layers = []
        models = []
        removeSlices()
    }
    
    open override func prepareForInterfaceBuilder() {
        animationDuration = 0
        strokeWidth = 1
        strokeColor = UIColor.lightGray
        
        let models = (0..<6).map {_ in
            PieSliceModel(value: 2, color: UIColor.clear)
        }
        
        self.models = models
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        container.frame = bounds
    }
}

extension PieChart: PieSliceDelegate {
    
    public func onStartAnimation(slice: PieSlice) {
        for layer in layers {
            layer.onStartAnimation(slice: slice)
        }
        delegate?.onStartAnimation(slice: slice)
    }
    
    public func onEndAnimation(slice: PieSlice) {
        for layer in layers {
            layer.onEndAnimation(slice: slice)
        }
        delegate?.onEndAnimation(slice: slice)
    }
    
    public func onSelected(slice: PieSlice, selected: Bool) {
        for layer in layers {
            layer.onSelected(slice: slice, selected: selected)
        }
        delegate?.onSelected(slice: slice, selected: selected)
    }
}

extension FloatingPoint {
    
    var degreesToRadians: Self {
        return self * .pi / 180
    }
    
    var radiansToDegrees: Self {
        return self * 180 / .pi
    }
    
    func truncate(_ fractions: Self) -> Self {
        return Darwin.round(self * fractions) / fractions
    }
    
    func truncateDefault() -> Self {
        return truncate(10000000)
    }
}

extension CGRect {
    
    var center: CGPoint {
        return CGPoint(x: origin.x + width / 2, y: origin.y + height / 2)
    }
}
