//
//  tubo.swift
//  moscaFly
//
//  Created by Desarrollo Uxi on 14/02/17.
//  Copyright © 2017 Alberto. All rights reserved.
//

import SpriteKit

class Tubo: SKSpriteNode {
    
    let texturas = ["Tubo1.png", "Tubo2.png"]
    
    init(indiceTextura:Int,  x: CGFloat, y: CGFloat, gapDificultad: CGFloat , compensacionTubos: CGFloat ){
       
        let texturaTubo = SKTexture(imageNamed: texturas[indiceTextura])
        super.init(texture: texturaTubo, color: UIColor.clear, size: texturaTubo.size())
        let puntoY : CGFloat
        if(indiceTextura == 0){
            puntoY = y + texturaTubo.size().height / 2 + gapDificultad + compensacionTubos
        }else{
            puntoY = y - texturaTubo.size().height / 2 - gapDificultad + compensacionTubos            
        }
        self.position = CGPoint(x:x , y: puntoY)
        self.zPosition = 1
        
        self.physicsBody = SKPhysicsBody(rectangleOf:texturaTubo.size() )
        self.physicsBody!.isDynamic = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


 /*
 tubo1.physicsBody!.categoryBitMask = tipoNodo.tuboSuelo.rawValue
 tubo1.physicsBody!.collisionBitMask = tipoNodo.mosca.rawValue
 tubo1.physicsBody!.contactTestBitMask = tipoNodo.mosca.rawValue
 
 tubo2.physicsBody!.categoryBitMask = tipoNodo.tuboSuelo.rawValue
 tubo2.physicsBody!.collisionBitMask = tipoNodo.mosca.rawValue
 tubo2.physicsBody!.contactTestBitMask = tipoNodo.mosca.rawValue
 */
