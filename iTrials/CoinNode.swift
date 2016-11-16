//
//  CoinNode.swift
//  iTrials
//
//  Created by Alex Fuerst on 11/14/16.
//  Copyright © 2016 student. All rights reserved.
//

import Foundation
import SpriteKit

class CoinNode: SKSpriteNode {
    var value: Int = 0
    
    func addedToScene(value:Int) {
        let label = self.childNode(withName: "ValueLabel") as! SKLabelNode
        label.text = String(value);
        self.value = value
        physicsBody?.collisionBitMask = GameData.PhysicsCategory.None
        physicsBody?.contactTestBitMask = GameData.PhysicsCategory.Car | GameData.PhysicsCategory.Wheels
        physicsBody?.categoryBitMask = GameData.PhysicsCategory.PickUp
    }
}
