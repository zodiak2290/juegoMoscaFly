//
//  Colisiones.swift
//  moscaFly
//
//  Created by Desarrollo Uxi on 14/02/17.
//  Copyright © 2017 Alberto. All rights reserved.
//

import UIKit

class Colisiones {
    
    enum tipoNodo: UInt32 {
        case mosca = 1
        case tuboSuelo = 2
        case espacioTubos = 4
    }
    
    func getConfigBitMaskMosca() -> [String: UInt32]{
        
        let configBitMask = [
            "categoryBitMask": tipoNodo.mosca.rawValue,
            "collisionBitMask": tipoNodo.tuboSuelo.rawValue,
            "contactTestBitMask": tipoNodo.tuboSuelo.rawValue | tipoNodo.espacioTubos.rawValue
        ]
        return configBitMask
    }
    
    func getConfigBitMaskEspacio()-> [String: UInt32] {
        
        let config = [
            "categoryBitMask": tipoNodo.espacioTubos.rawValue,
            "collisionBitMask": 0,
            "contactTestBitMask": tipoNodo.mosca.rawValue
        ]
        return config
    }
}
