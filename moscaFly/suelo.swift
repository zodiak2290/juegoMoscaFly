//
//  suelo.swift
//  moscaFly
//
//  Created by Desarrollo Uxi on 14/02/17.
//  Copyright © 2017 Alberto. All rights reserved.
//

import SpriteKit

class Suelo: SKNode {
    
    init(posicion: CGPoint, ancho : CGFloat) {
        super.init()
        
        self.position = posicion
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: ancho, height:1))
        self.physicsBody!.isDynamic = false

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

/*
 suelo.physicsBody!.categoryBitMask = tipoNodo.tuboSuelo.rawValue
 suelo.physicsBody!.collisionBitMask = tipoNodo.mosca.rawValue
 suelo.physicsBody!.contactTestBitMask = tipoNodo.mosca.rawValue

 */
