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
    
    struct PhysicsCategory {
        static let None: UInt32 =   0
        static let Car: UInt32 =    0b1 // 1
        static let Wheels: UInt32 = 0b10 // 2
        static let Finish: UInt32 = 0b100 // 4
        static let Ground: UInt32 = 0b1000 // 8
        static let Label: UInt32 =  0b10000 // 16
        static let PickUp: UInt32 = 0b100000 // 32
    }
    
    struct GameLayer {
        static let background: CGFloat = 0
        static let hud       : CGFloat = 1
        static let sprite    : CGFloat = 2
        static let message   : CGFloat = 3
    }
    
    static func getPlayableRect(game: GameScene) -> CGRect{
        
        // Calculate playable margin
        let maxAspectRatio: CGFloat = 16.0/9.0
        let maxAspectRatioHeight = game.size.width / maxAspectRatio
        let playableMargin: CGFloat = (game.size.height - maxAspectRatioHeight)/2
        return CGRect(x: 0, y: playableMargin, width: game.size.width, height: game.size.height-playableMargin*2)
    }
}
