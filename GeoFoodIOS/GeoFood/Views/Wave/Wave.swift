//
//  Wave.swift
//  GeoFood
//
//  Created by Егор on 25.03.2021.
//

import UIKit

class Wave: UIView {

    let graphWidth: CGFloat = 1
    let amplitude: CGFloat = 0.3
    
    override func draw(_ rect: CGRect) {
        let width = rect.width
        let height = rect.height

        let origin = CGPoint(x: width * (1 - graphWidth) / 2, y: height * 0.50)

        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: origin)

        for angle in stride(from: 5.0, through: 360.0, by: 5.0) {
            let x = origin.x + CGFloat(angle/240) * width * graphWidth
            let y = origin.y - CGFloat(sin(angle/180 * Double.pi)) * height * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: width, y: rect.maxY))
        UIColor.green.setFill()
        path.fill()
    }

}
