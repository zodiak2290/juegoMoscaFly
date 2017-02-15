//
//  GameScene.swift
//  moscaFly
//
//  Created by Desarrollo Uxi on 14/02/17.
//  Copyright © 2017 Alberto. All rights reserved.
//

import SpriteKit
import GameplayKit
class GameScene: SKScene, SKPhysicsContactDelegate {
    


    var puntuacion = 0
    var timer = Timer()
    var gameOver = false
    //objetos
    var fondo: Fondo?
    var mosca: Mosca?
    var tubo1 :Tubo?
    var tubo2: Tubo?
    
    var colisiones = Colisiones()
    
    var labelPuntuacion: LabelPuntaje?
    
    enum tipoNodo: UInt32 {
        case mosca = 1
        case tuboSuelo = 2
        case espacioTubos = 4
    }
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        reiniciar()
    }
    
    func addLabelPuntuacion(){
        labelPuntuacion = LabelPuntaje()
        self.addChild(labelPuntuacion!)
    }
    

    func addMosca(){
        let configBitMask = colisiones.getConfigBitMaskMosca()
        let x = self.frame.minX + (self.frame.maxX / 4)
        let posicion =  CGPoint(x: x, y:self.frame.midY )
        self.mosca = Mosca(posicion: posicion)
        self.mosca?.setBitMask(with: configBitMask)
        self.addChild(mosca!)
    }
    
    //NODOS
    
    func añadirFondo(){
        var i:CGFloat = 0
        while i < 2 {
            fondo = Fondo(altura: self.frame.height, origenX: i, origenY: self.frame.midY)
            fondo?.desplazar()
            self.addChild(fondo!)
            i += 1
        }
        
    }
    
    func añadirSuelo(){
        let suelo = Suelo(posicion:CGPoint(x:-self.frame.midX, y: -self.frame.height/2), ancho: self.frame.width)
        self.addChild(suelo)
    }
    
    func añadirTubosEspacios(){
        
        let moverTubos = SKAction.move(by: CGVector(dx: -3 * self.frame.width, dy: 0), duration: TimeInterval(self.frame.width / 100))
        
        let removerTubos = SKAction.removeFromParent()
        
        let moverRemoverTubos = SKAction.sequence([moverTubos,removerTubos])
        
        
        let gapDificultad = (mosca?.size.height)! * 3
        //print(gapDificultad)
        // Numero entre cero y la mitad del alto de la pantalla
        let cantidadMovimientoAleatorio = CGFloat(arc4random() % UInt32(self.frame.height/2))
        
        let compensacionTubos =  cantidadMovimientoAleatorio - self.frame.height / 4
        
        let x = self.frame.midX + self.frame.width
        let frameMidY = self.frame.midY
        tubo1 = Tubo(indiceTextura: 0, x: x, y: frameMidY, gapDificultad: gapDificultad, compensacionTubos: compensacionTubos)
        tubo1?.run(moverRemoverTubos)
        
        self.addChild(tubo1!)
        
        tubo2 = Tubo(indiceTextura: 1, x: x, y: frameMidY, gapDificultad: gapDificultad, compensacionTubos: compensacionTubos)
        
        let texturaTubo2 = SKTexture(imageNamed:"Tubo2.png")
        
        tubo2?.run(moverRemoverTubos)
        
        self.addChild(tubo2!)
        //Espacios
        let espacio = SKSpriteNode()
        espacio.position = CGPoint(x:self.frame.midX + self.frame.width , y:self.frame.midY + compensacionTubos)
        espacio.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width:texturaTubo2.size().width , height: (mosca?.size.height)! * 3))
        espacio.physicsBody!.isDynamic = false
        espacio.zPosition = 1
        espacio.physicsBody!.categoryBitMask = tipoNodo.espacioTubos.rawValue
        espacio.physicsBody!.collisionBitMask = 0
        espacio.physicsBody!.contactTestBitMask = tipoNodo.mosca.rawValue
        espacio.run(moverRemoverTubos)
        self.addChild(espacio)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if gameOver == false{
            mosca?.impulsar()
        }else{
            gameOver = false
            puntuacion = 0
            self.speed = 1
            self.removeAllChildren()
            reiniciar()
        }
    }
    
    func reiniciar(){
        //Timer Tubos
        timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.añadirTubosEspacios), userInfo: nil, repeats: true)
        //Label Puntuacion
        addLabelPuntuacion()
        //MOSCA
        addMosca()
        //FONDO
        añadirFondo()
        //Suelo
        añadirSuelo()
        //TUBOS //Espacio entre tubos
        añadirTubosEspacios()
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let cuerpoA = contact.bodyA.categoryBitMask
        let cuerpoB = contact.bodyB.categoryBitMask
        
        let moscaRaw = tipoNodo.mosca.rawValue
        let espacioRaw = tipoNodo.espacioTubos.rawValue
        
        let isMoscaA = cuerpoA == moscaRaw
        let isEspacioB = cuerpoB == espacioRaw
        
        let isEspacioA = cuerpoA == espacioRaw
        let isMoscaB = cuerpoB == moscaRaw
        
        if (isMoscaA  && isEspacioB) || (isEspacioA && isMoscaB ) {
            puntuacion += 1
            labelPuntuacion?.text = String(puntuacion)
        }else{
            gameOver = true
            self.speed = 0
            timer.invalidate()
            labelPuntuacion?.text = "Game Over"
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    
}
