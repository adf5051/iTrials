//
//  CarTest.swift
//  iTrials
//
//  Created by Alex Fuerst on 11/9/16.
//  Copyright © 2016 student. All rights reserved.
//

import Foundation
import SpriteKit

class Car {
    
    private var leftWheel:SKNode
    private var rightWheel:SKNode
    private var body:SKNode
    private var car:SKSpriteNode
    private var top:SKNode
    private let topPos:CGPoint = CGPoint(x: 0, y: 25)
    
    var carNode:SKSpriteNode{
        get{
            return self.car
        }
    }    
    private let torque:CGFloat = 1
    private let liftForce:CGFloat = 430
    private let tireFriction:CGFloat = 10
    private let speedAndForceThreshold:CGFloat = 10000
    
    private var up:CGVector{
        get{
            var worldUp = CGVector(dx:0,dy:1)
            worldUp.rotate(angleInRad: body.zRotation)
            return worldUp
        }
    }
    
    init(scene:SKScene) {
        car = SKSpriteNode(color: SKColor.yellow, size: CGSize(width: 150, height: 50))
        car.position = CGPoint(x:250,y:1000)
        car.physicsBody = SKPhysicsBody(rectangleOf: car.size)
        car.physicsBody!.categoryBitMask = GameData.PhysicsCategory.Car
        car.physicsBody!.collisionBitMask = GameData.PhysicsCategory.Ground
        car.physicsBody!.contactTestBitMask = GameData.PhysicsCategory.Ground | GameData.PhysicsCategory.Finish | GameData.PhysicsCategory.PickUp
        
        scene.addChild(car)
        body = car
        
        let top = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 100, height: 25))
        top.position = topPos + car.position
        top.physicsBody = SKPhysicsBody(rectangleOf: top.size)
        top.physicsBody!.categoryBitMask = GameData.PhysicsCategory.CarTop
        top.physicsBody!.collisionBitMask = GameData.PhysicsCategory.None
        top.physicsBody!.contactTestBitMask = GameData.PhysicsCategory.Ground
        top.physicsBody!.affectedByGravity = false
        scene.addChild(top)
        self.top = top
        
        let lWheel = SKShapeNode(circleOfRadius: 30)
        let line = SKShapeNode(rectOf: CGSize(width: 4, height: 30))
        line.lineWidth = 4
        line.position = lWheel.position
        line.position.y -= 15
        
        lWheel.lineWidth = 4
        lWheel.name = "drive"
        lWheel.addChild(line)
        lWheel.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        lWheel.position = CGPoint(x:car.position.x-80,y:car.position.y-15)
        lWheel.physicsBody?.friction = tireFriction
        lWheel.physicsBody!.categoryBitMask = GameData.PhysicsCategory.Wheels
        lWheel.physicsBody!.collisionBitMask = GameData.PhysicsCategory.Ground
        lWheel.physicsBody!.contactTestBitMask = GameData.PhysicsCategory.Finish | GameData.PhysicsCategory.PickUp | GameData.PhysicsCategory.Ground
        
        let rWheel = SKShapeNode(circleOfRadius: 30)
        let rline = SKShapeNode(rectOf: CGSize(width: 4, height: 30))
        rline.lineWidth = 4
        rline.position = rWheel.position;
        rline.position.y -= 15
        rWheel.addChild(rline)
        
        rWheel.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        rWheel.position = CGPoint(x:car.position.x+80,y:car.position.y-15)
        rWheel.physicsBody?.friction = tireFriction
        rWheel.physicsBody!.categoryBitMask = GameData.PhysicsCategory.Wheels
        rWheel.physicsBody!.collisionBitMask = GameData.PhysicsCategory.Ground
        rWheel.physicsBody!.contactTestBitMask = GameData.PhysicsCategory.Finish | GameData.PhysicsCategory.PickUp | GameData.PhysicsCategory.Ground
        rWheel.lineWidth = 4
        
        scene.addChild(lWheel)
        scene.addChild(rWheel)
        
        leftWheel = lWheel
        rightWheel = rWheel
        
        let lPin = SKPhysicsJointPin.joint(withBodyA: car.physicsBody!, bodyB: lWheel.physicsBody!, anchor: lWheel.position)
        let rPin = SKPhysicsJointPin.joint(withBodyA: car.physicsBody!, bodyB: rWheel.physicsBody!, anchor: rWheel.position)
        let tPin = SKPhysicsJointFixed.joint(withBodyA: body.physicsBody!, bodyB: top.physicsBody!, anchor: top.position)
        
        scene.physicsWorld.add(lPin)
        scene.physicsWorld.add(rPin)
        scene.physicsWorld.add(tPin)
    }
    
    public func update() {
//        top.position = CGPoint.zero
//        top.zRotation = body.zRotation
//        top.position = topPos;
    }
    
    private func scaleForceByVelocity() -> CGFloat {
        var vel:CGFloat! = body.physicsBody?.velocity.length()
        
        if vel > speedAndForceThreshold {
            return 0
        }
        
        // convert vel to a range of 0 - 500
        vel = speedAndForceThreshold - vel
        
        return vel / speedAndForceThreshold
    }
    
    func drive(){
        let liftScalar = scaleForceByVelocity()
        
        leftWheel.physicsBody?.applyTorque(-torque)
        rightWheel.physicsBody?.applyForce(up * liftForce * liftScalar)
    }
    
    func reverse(){
        let liftScalar = scaleForceByVelocity()
        
        leftWheel.physicsBody?.applyTorque(torque)
        rightWheel.physicsBody?.applyForce(up * -liftForce * liftScalar)
    }
    
    
}
