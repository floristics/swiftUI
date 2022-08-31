//
//  Pie.swift
//  Memorize
//
//  Created by Павел Родионов on 11.08.2022.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    init(startAngle: Int, endAngle: Int, clockwise: Bool = false) {
        self.startAngle = Angle(degrees: CGFloat(startAngle))
        self.endAngle = Angle(degrees: CGFloat(endAngle))
        self.clockwise = clockwise
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        
        let radius = min(rect.width, rect.height) / 2
        
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)) ,
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center,
                 radius: radius,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: !clockwise)
        p.addLine(to: center)
        
        return p
    }
}
