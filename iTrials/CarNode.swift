//
//  Car.swift
//  iTrials
//
//  Created by student on 11/8/16.
//  Copyright © 2016 student. All rights reserved.
//

import SpriteKit

class CarNode: SKSpriteNode {
    
    func didMoveToScene() {
        
        //grab the physics world and set up car springs
        print("car added to scene")
        let world = scene?.physicsWorld
        
        let rWheel = childNode(withName: "rWheel") as! SKSpriteNode
        let lWheel = childNode(withName: "lWheel") as! SKSpriteNode
        let rBodyAnchor = childNode(withName: "rSideAnchor") as! SKSpriteNode
        let lBodyAnchor = childNode(withName: "lSideAnchor") as! SKSpriteNode
        
        let frontSpring = SKPhysicsJointSpring.joint(withBodyA: self.physicsBody!, bodyB: rWheel.physicsBody!, anchorA: rBodyAnchor.position, anchorB: rWheel.position)
        let rearSpring = SKPhysicsJointSpring.joint(withBodyA: self.physicsBody!, bodyB: lWheel.physicsBody!, anchorA: lBodyAnchor.position, anchorB: lWheel.position)
        
        frontSpring.frequency = 2.0
        rearSpring.frequency = 2.0
        
        
        world?.add(frontSpring)
        world?.add(rearSpring)
    }
}
