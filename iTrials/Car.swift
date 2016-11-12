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
    
    private let torque:CGFloat = 1
    private let liftForce:CGFloat = 450
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
        let car = SKSpriteNode(color: SKColor.yellow, size: CGSize(width: 150, height: 50))
        car.position = CGPoint(x:250,y:1000)
        car.physicsBody = SKPhysicsBody(rectangleOf: car.size)
        
        scene.addChild(car)
        body = car
        
        let lWheel = SKShapeNode(circleOfRadius: 30)
        let line = SKShapeNode(rectOf: CGSize(width: 4, height: 30))
        line.lineWidth = 4
        line.position = lWheel.position;
        line.position.y -= 15
        
        lWheel.lineWidth = 4
        lWheel.name = "drive"
        lWheel.addChild(line)
        lWheel.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        lWheel.position = CGPoint(x:car.position.x-80,y:car.position.y-10)
        lWheel.physicsBody?.friction = tireFriction
        
        let rWheel = SKShapeNode(circleOfRadius: 30)
        let rline = SKShapeNode(rectOf: CGSize(width: 4, height: 30))
        rline.lineWidth = 4
        rline.position = rWheel.position;
        rline.position.y -= 15
        rWheel.addChild(rline)
        
        rWheel.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        rWheel.position = CGPoint(x:car.position.x+80,y:car.position.y-10)
        rWheel.physicsBody?.friction = tireFriction
        rWheel.lineWidth = 4
        
        scene.addChild(lWheel)
        scene.addChild(rWheel)
        
        leftWheel = lWheel
        rightWheel = rWheel
        
        let lPin = SKPhysicsJointPin.joint(withBodyA: car.physicsBody!, bodyB: lWheel.physicsBody!, anchor: lWheel.position)
        let rPin = SKPhysicsJointPin.joint(withBodyA: car.physicsBody!, bodyB: rWheel.physicsBody!, anchor: rWheel.position)
        
        scene.physicsWorld.add(lPin)
        scene.physicsWorld.add(rPin)
    }
    
    private func scaleForceByVelocity() -> CGFloat {
        var vel:CGFloat! = body.physicsBody?.velocity.length()
       
        if vel > speedAndForceThreshold {
            return 0
        }
        
        // convert vel to a range of 0 - 500
        vel = speedAndForceThreshold - vel
       
        return vel / speedAndForceThreshold;
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
