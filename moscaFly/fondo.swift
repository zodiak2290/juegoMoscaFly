//
//  fondo.swift
//  moscaFly
//
//  Created by Desarrollo Uxi on 14/02/17.
//  Copyright © 2017 Alberto. All rights reserved.
//

import SpriteKit

class Fondo: SKSpriteNode {
    
    var animacionVuelo : SKAction?
    
    let texturaFondo = SKTexture(imageNamed:"fondo.png")
    var movimientoInfinitoFondo: SKAction?
    
    init(altura: CGFloat, origenX: CGFloat, origenY: CGFloat) {
        super.init(texture: texturaFondo, color: UIColor.clear, size: texturaFondo.size())
        
        let movimientoFondo = SKAction.move(by: CGVector(dx: -texturaFondo.size().width, dy:0), duration:8)
        let movimientoFondoOrigen = SKAction.move(by: CGVector(dx: texturaFondo.size().width, dy:0), duration:0)
            self.movimientoInfinitoFondo = SKAction.repeatForever(SKAction.sequence([movimientoFondo,movimientoFondoOrigen]))
        self.zPosition = -1
        self.size.height = altura
        self.position = CGPoint(x: texturaFondo.size().width * origenX , y: origenY)
    }
    
    func desplazar(){
         self.run(movimientoInfinitoFondo!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


/*
 fondo.position = CGPoint(x:texturaFondo.size().width * i, y: self.frame.midY)
 

 
 
 i += 1
 
 */
