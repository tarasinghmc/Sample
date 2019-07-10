//
//  LineChart.swift
//  LineChartDemo
//
//  Created by Tara Singh M C on 10/07/19.
//  Copyright © 2019 Tara Singh. All rights reserved.
//

import UIKit

class LineChart: UIView {
    public struct Labels {
        public var values: [String] = []
    }
    
    public struct Grid {
        public var count: CGFloat = 2
        // #eeeeee
        public var color: UIColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
    }
    
    public struct Axis {
        // #607d8b
        public var color: UIColor = UIColor(red: 96/255.0, green: 125/255.0, blue: 139/255.0, alpha: 1)
        public var inset: CGFloat = 15
    }
    
    public struct Coordinate {
        // public
        public var labels: Labels = Labels()
        public var grid: Grid = Grid()
        public var axis: Axis = Axis()
        
        fileprivate var space: CGFloat!

    }
    
    private let mainLayer: CALayer = CALayer()
    private let scrollView: UIScrollView = UIScrollView()
    public var x = Coordinate()
    public var y = Coordinate()

    fileprivate var drawingHeight: CGFloat = 0 {
        didSet {
            //y.space =  (drawingHeight) / y.grid.count
            y.space =  (drawingHeight) * 0.25
        }
    }
    fileprivate var drawingWidth: CGFloat = 0 {
        didSet {
    
            //x.space = (drawingWidth) / x.grid.count
            x.space = (drawingWidth) * 0.25

        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        scrollView.layer.addSublayer(mainLayer)
        self.addSubview(scrollView)
        
    }
    
    override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
    }
    
    func drawGraph() {
        // Remove previous
        self.mainLayer.sublayers?.forEach({$0.removeFromSuperlayer()})
        
        self.drawingHeight = self.bounds.height - (2 * y.axis.inset)
        self.drawingWidth = self.bounds.width  - (2 * x.axis.inset)
        
        drawGrid()
        
    }
    /**
     * Draw x grid.
     */
    fileprivate func drawXGrid() {
        
        let path = UIBezierPath()
        var x1: CGFloat
        let y1: CGFloat = self.bounds.height - y.axis.inset
        let y2: CGFloat = y.axis.inset
        
        var i:CGFloat = 0
        while i <= x.grid.count {
            print(i)
            x1 = (i * x.space) + x.axis.inset
            path.move(to: CGPoint(x: x1, y: y1))
            path.addLine(to: CGPoint(x: x1, y: y2))
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.strokeColor = x.grid.color.cgColor
            mainLayer.addSublayer(layer)
            i += 1
        }
    }
    
    /**
     * Draw y grid.
     */
    fileprivate func drawYGrid() {
        let path = UIBezierPath()
        let x1: CGFloat = x.axis.inset
        let x2: CGFloat = self.bounds.width - x.axis.inset
        var y1: CGFloat
        var i:CGFloat = 0
        while i < y.grid.count {
            y1 = self.bounds.height - (i * x.space) - y.axis.inset
            path.move(to: CGPoint(x: x1, y: y1))
            path.addLine(to: CGPoint(x: x2, y: y1))
            let layer = CAShapeLayer()
            layer.path = path.cgPath
            layer.strokeColor = y.grid.color.cgColor
            mainLayer.addSublayer(layer)
            i += 1
        }
    }
    
    /**
     * Draw grid.
     */
    fileprivate func drawGrid() {
        drawXGrid()
        drawYGrid()
    }
}

