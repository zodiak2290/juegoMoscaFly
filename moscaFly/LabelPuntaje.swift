//
//  LabelPuntaje.swift
//  moscaFly
//
//  Created by Desarrollo Uxi on 14/02/17.
//  Copyright © 2017 Alberto. All rights reserved.
//

import SpriteKit

class LabelPuntaje : SKLabelNode {

    override init() {
        super.init()
        self.fontName = "Helvetica Neue"
        self.fontSize = 90
        self.text = "0"
        self.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 500)
        self.zPosition = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
