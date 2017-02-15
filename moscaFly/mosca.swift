//
//  mosca.swift
//  moscaFly
//
//  Created by Desarrollo Uxi on 14/02/17.
//  Copyright © 2017 Alberto. All rights reserved.
//

import SpriteKit

class Mosca: SKSpriteNode {
    

    var animacionVuelo : SKAction?
    
    let texturaMosca1 = SKTexture(imageNamed:"../fly1.png")
    let texturaMosca2 = SKTexture(imageNamed:"../fly2.png")
    init(posicion: CGPoint) {
        
        super.init(texture: texturaMosca1, color: UIColor.clear, size: texturaMosca1.size())
        //self.position = CGPoint(x: -100   , y:self.frame.midY )
        print(self.frame.maxX)
        self.physicsBody = SKPhysicsBody(circleOfRadius:texturaMosca1.size().height/2)
        self.physicsBody!.isDynamic = false
        let animacion = SKAction.animate(with:[ self.texturaMosca1,
                                                self.texturaMosca2],
                                         timePerFrame: 0.003)
        self.animacionVuelo = SKAction.repeatForever(animacion)
        self.zPosition = 1
        self.position = posicion
        volar()
        
    }
    
    func setBitMask(with configBitMask: [String: UInt32]) {
        self.physicsBody!.categoryBitMask = configBitMask["categoryBitMask"]!
        self.physicsBody!.collisionBitMask = configBitMask["collisionBitMask"]!
        self.physicsBody!.contactTestBitMask = configBitMask["contactTestBitMask"]!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func volar(){
        self.run(self.animacionVuelo!)
    }
    
    func impulsar() {
        self.physicsBody!.isDynamic = true
        self.physicsBody!.velocity = (CGVector(dx: 0 , dy: 30) )
        self.physicsBody!.applyImpulse(CGVector(dx: 0 , dy: 70) )
    }
    
}
