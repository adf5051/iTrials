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
    
    private var scale:CGFloat = 1.5
    
    // figure these out by dragging everything into a scene file and lining it up
    // then if you scale the body in any way scale these too
    private var lWheelOffset:CGPoint = CGPoint(x: -195, y: -108)
    private var rWheelOffset:CGPoint = CGPoint(x: 210, y: -112)
    private var guyOffset:CGPoint = CGPoint(x: -16, y: 58)
    
    private var leftWheel:SKNode
    private var rightWheel:SKNode
    private var body:SKNode
    private var car:SKSpriteNode
    private var top:SKNode
    
    var carNode:SKSpriteNode{
        get{
            return self.car
        }
    }    
    private let torque:CGFloat = 3
    private let liftForce:CGFloat = 500
    private let tireFriction:CGFloat = 100
    private let speedAndForceThreshold:CGFloat = 10000
    
    private var up:CGVector{
        get{
            var worldUp = CGVector(dx:0,dy:1)
            worldUp.rotate(angleInRad: body.zRotation)
            return worldUp
        }
    }
    
    init(scene:SKScene) {
        lWheelOffset = lWheelOffset/scale
        rWheelOffset = rWheelOffset/scale
        guyOffset = guyOffset/scale
        
        car = SKSpriteNode(imageNamed: "BikeBody")
        car.size = CGSize(width: car.size.width/scale,height:car.size.height/scale);
        car.position = CGPoint(x:250,y:1000)
        car.physicsBody = SKPhysicsBody(rectangleOf: car.size)
        car.physicsBody?.mass = 0.5
        car.physicsBody!.categoryBitMask = GameData.PhysicsCategory.Car
        car.physicsBody!.collisionBitMask = GameData.PhysicsCategory.Ground
        car.physicsBody!.contactTestBitMask = GameData.PhysicsCategory.Ground | GameData.PhysicsCategory.Finish | GameData.PhysicsCategory.PickUp
        car.physicsBody!.usesPreciseCollisionDetection = true
        
        scene.addChild(car)
        body = car
        
        let top = SKSpriteNode(imageNamed:"Guy")
        top.size = CGSize(width: top.size.width/scale, height: top.size.height/scale)
        top.position = guyOffset + car.position
        top.physicsBody = SKPhysicsBody(rectangleOf: top.size)
        top.physicsBody!.categoryBitMask = GameData.PhysicsCategory.CarTop
        top.physicsBody!.collisionBitMask = GameData.PhysicsCategory.None
        top.physicsBody!.contactTestBitMask = GameData.PhysicsCategory.Ground
        top.physicsBody!.affectedByGravity = false
        top.physicsBody!.usesPreciseCollisionDetection = true
        
        scene.addChild(top)
        self.top = top
        
        let lWheel = SKSpriteNode(imageNamed: "wheel")
        lWheel.size = CGSize(width: lWheel.size.width/scale, height: lWheel.size.height/scale)
//        let line = SKShapeNode(rectOf: CGSize(width: 4, height: 30))
//        line.lineWidth = 4
//        line.position = lWheel.position
//        line.position.y -= 15
        
//        lWheel.lineWidth = 4
        lWheel.name = "drive"
//        lWheel.addChild(line)
        lWheel.physicsBody = SKPhysicsBody(circleOfRadius: lWheel.size.width/2)
        lWheel.position = car.position + lWheelOffset
        lWheel.physicsBody?.mass = 0.5
        lWheel.physicsBody?.friction = tireFriction
        lWheel.physicsBody!.categoryBitMask = GameData.PhysicsCategory.Wheels
        lWheel.physicsBody!.collisionBitMask = GameData.PhysicsCategory.Ground
        lWheel.physicsBody!.contactTestBitMask = GameData.PhysicsCategory.Finish | GameData.PhysicsCategory.PickUp | GameData.PhysicsCategory.Ground
        lWheel.physicsBody!.usesPreciseCollisionDetection = true
        
        let rWheel = SKSpriteNode(imageNamed: "wheel")
        rWheel.size = CGSize(width: rWheel.size.width/scale, height: rWheel.size.height/scale)
        
//        let rline = SKShapeNode(rectOf: CGSize(width: 4, height: 30))
//        rline.lineWidth = 4
//        rline.position = rWheel.position;
//        rline.position.y -= 15
//        rWheel.addChild(rline)
        
        rWheel.physicsBody = SKPhysicsBody(circleOfRadius: rWheel.size.width/2)
        rWheel.position = car.position + rWheelOffset
        rWheel.physicsBody?.mass = 0.5
        rWheel.physicsBody?.friction = tireFriction
        rWheel.physicsBody!.categoryBitMask = GameData.PhysicsCategory.Wheels
        rWheel.physicsBody!.collisionBitMask = GameData.PhysicsCategory.Ground
        rWheel.physicsBody!.contactTestBitMask = GameData.PhysicsCategory.Finish | GameData.PhysicsCategory.PickUp | GameData.PhysicsCategory.Ground
        rWheel.physicsBody!.usesPreciseCollisionDetection = true
//        rWheel.lineWidth = 4
        
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
