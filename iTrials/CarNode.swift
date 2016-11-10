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
        
        let chassis = childNode(withName: "carBody") as! SKSpriteNode
        
        let rWheel = childNode(withName: "rWheel") as! SKSpriteNode
        let lWheel = childNode(withName: "lWheel") as! SKSpriteNode
//        let rBodyAnchor = childNode(withName: "rSideAnchor") as! SKSpriteNode
//        let lBodyAnchor = childNode(withName: "lSideAnchor") as! SKSpriteNode
        
        let leftPinJoint = SKPhysicsJointPin.joint(withBodyA: chassis.physicsBody!, bodyB: lWheel.physicsBody!, anchor: lWheel.position)
        
        let rightPinJoint = SKPhysicsJointPin.joint(withBodyA: chassis.physicsBody!, bodyB: rWheel.physicsBody!, anchor: rWheel.position)
        
        world?.add(leftPinJoint)
        world?.add(rightPinJoint)
        
//        let leftSlide = SKPhysicsJointSliding.joint(withBodyA:chassis!.physicsBody!, bodyB: lBodyAnchor.physicsBody!, anchor:CGPoint(x:lBodyAnchor.position.x, y:lBodyAnchor.position.y), axis:CGVector(dx:0, dy:1))
//        
//        leftSlide.shouldEnableLimits = true;
//        leftSlide.lowerDistanceLimit = 5;
//        leftSlide.upperDistanceLimit = 60;
//        
//        let leftSpring = SKPhysicsJointSpring.joint(withBodyA: chassis!.physicsBody!, bodyB: lWheel.physicsBody!, anchorA: lBodyAnchor.position, anchorB: lWheel.position)
//        
//        leftSpring.damping = 1
//        leftSpring.frequency = 4
//        
//        let lPin = SKPhysicsJointPin.joint(withBodyA:lBodyAnchor.physicsBody!, bodyB:lWheel.physicsBody!, anchor:lWheel.position)
//        
//        let rightSlide = SKPhysicsJointSliding.joint(withBodyA:chassis!.physicsBody!, bodyB: rBodyAnchor.physicsBody!, anchor:CGPoint(x:rBodyAnchor.position.x, y:rBodyAnchor.position.y), axis:CGVector(dx:0, dy:1))
//        
//        rightSlide.shouldEnableLimits = true;
//        rightSlide.lowerDistanceLimit = 5;
//        rightSlide.upperDistanceLimit = 60;
//        
//        let rightSpring = SKPhysicsJointSpring.joint(withBodyA: chassis!.physicsBody!, bodyB: rWheel.physicsBody!, anchorA: rBodyAnchor.position, anchorB: rWheel.position)
//        
//        rightSpring.damping = 1
//        rightSpring.frequency = 4
//        
//        let rPin = SKPhysicsJointPin.joint(withBodyA:rBodyAnchor.physicsBody!, bodyB:rWheel.physicsBody!, anchor:rWheel.position)
//        
//        world?.add(leftSpring)
//        world?.add(rightSpring)
//        world?.add(leftSlide)
//        world?.add(rightSlide)
//        world?.add(rPin)
//        world?.add(lPin)
    }
}
