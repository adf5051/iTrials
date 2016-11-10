//
//  CarTest.swift
//  iTrials
//
//  Created by Alex Fuerst on 11/9/16.
//  Copyright © 2016 student. All rights reserved.
//

import Foundation
import SpriteKit

class CarTest: SKNode {
    
    override init() {
        super.init()
        
        let body = SKSpriteNode(color: SKColor.yellow, size: CGSize(width: 150, height: 50))
        body.position = CGPoint(x:100,y:600)
        body.physicsBody = SKPhysicsBody(rectangleOf: body.size)
        
        scene?.addChild(body)
        
        let lWheel = SKShapeNode(circleOfRadius: 30)
        lWheel.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        lWheel.position = CGPoint(x:body.position.x-80,y:body.position.y)
        
        let rWheel = SKShapeNode(circleOfRadius: 30)
        rWheel.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        lWheel.position = CGPoint(x:body.position.x+80,y:body.position.y)
        
        scene?.addChild(lWheel)
        scene?.addChild(rWheel)
        
        let lPin = SKPhysicsJointPin.joint(withBodyA: body.physicsBody!, bodyB: lWheel.physicsBody!, anchor: lWheel.position)
        let rPin = SKPhysicsJointPin.joint(withBodyA: body.physicsBody!, bodyB: rWheel.physicsBody!, anchor: rWheel.position)
        
        scene?.physicsWorld.add(lPin)
        scene?.physicsWorld.add(rPin)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
