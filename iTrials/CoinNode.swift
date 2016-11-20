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
        label.text = String(value)
        self.value = value
        physicsBody?.collisionBitMask = GameData.PhysicsCategory.None
        physicsBody?.contactTestBitMask = GameData.PhysicsCategory.Car | GameData.PhysicsCategory.Wheels
        physicsBody?.categoryBitMask = GameData.PhysicsCategory.PickUp
    }
    
    func deleteFromScene() {
        physicsBody = nil
        let coinSpark = SKEmitterNode(fileNamed: "PickupEmitter")
        let lifetime = SKAction.sequence([ SKAction.wait(forDuration: 0.75), SKAction.removeFromParent()])
        
        run(SKAction.sequence([
            SKAction.scale(to: 1.5, duration: 0.2),
            SKAction.scale(to: 0.25, duration: 0.1),
            SKAction.run({
                self.scene?.addChild(coinSpark!)
                coinSpark?.position = self.convert(self.position, to: self.scene!)
                coinSpark?.run(lifetime);
            }),
            SKAction.playSoundFileNamed("coin-drop", waitForCompletion: false),
            SKAction.removeFromParent()
            ]))
    }
}
