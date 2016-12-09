//
//  GameData.swift
//  iTrials
//
//  Created by Chad on 11/13/16.
//  Copyright © 2016 student. All rights reserved.
//

import Foundation
import SpriteKit

struct GameData {
    
    init(){
        fatalError("The GameData struct is a singleton")
    }
    
    struct Font{
        static let mainFont = "NicknameDEMO"
    }
    
    struct Game {
        static let maxLevel = 3
        static var level1:Level = Level(levelNum: 1)
        static var level2:Level = Level(levelNum: 2)
        static var level3:Level = Level(levelNum: 3)
    }
    
    struct PhysicsCategory {
        static let None: UInt32 =   0
        static let Car: UInt32 =    0b1 // 1
        static let Wheels: UInt32 = 0b10 // 2
        static let Finish: UInt32 = 0b100 // 4
        static let Ground: UInt32 = 0b1000 // 8
        static let Label: UInt32 =  0b10000 // 16
        static let PickUp: UInt32 = 0b100000 // 32
        static let CarTop: UInt32 = 0b1000000 // 64
    }
    
    struct GameLayer {
        static let background   : CGFloat = 0
        static let pickups      : CGFloat = 1
        static let pickupLabels : CGFloat = 2
        static let hud          : CGFloat = 3
        static let sprite       : CGFloat = 4
        static let message      : CGFloat = 5
    }
}
