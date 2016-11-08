//
//  Button.swift
//  iTrials
//
//  Created by Alex Fuerst on 11/7/16.
//  Copyright © 2016 student. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class Button: SKNode {
    
    // -- MARK: Instance Variables
    
    private var pressCallbacks:[String:()->()] = [:]
    private var releaseCallbacks:[String:()->()] = [:]
    
    public var pressAnimation:SKAction!
    public var releaseAnimation:SKAction!
    
    // -- MARK: Subscription Modifiers
    
    public func subscribeToPress(funcName:String,callback: @escaping ()->()){
        pressCallbacks[funcName] = callback
    }
    
    public func subscribeToRelease(funcName:String,callback: @escaping ()->()){
        releaseCallbacks[funcName] = callback
    }
    
    public func unsubscribeToPress(funcName:String){
        pressCallbacks.removeValue(forKey: funcName)
    }
    
    public func unsubscribeToRelease(funcName:String){
        releaseCallbacks.removeValue(forKey: funcName)
    }
    
    // -- MARK: Initialization
    
    // Designated init. Takes a node as a the button ui and makes it a child node
    init(_ buttonNode:SKNode) {
        super.init()
        self.addChild(buttonNode);
    }
    
    // required init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // setup function to be used with scene editor created buttons
    public func setup() {
        self.isUserInteractionEnabled = true;
    }
    
    // -- MARK: Touch Events --
    
    // Override the touch events to intercept touches on the button
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if pressAnimation != nil {
            run(pressAnimation)
        }
        
        firePressCallbacks()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if releaseAnimation != nil {
            run(releaseAnimation)
        }
        
        fireReleaseCallbacks()
    }
    
    // -- MARK: Fire Callbacks
    
    // The button was pressed, let all subscribers know
    func firePressCallbacks(){
        for (_,callback) in pressCallbacks {
            callback();
        }
    }
    
    // The button was released, let all subscribers know
    func fireReleaseCallbacks(){
        for (_,callback) in releaseCallbacks {
            callback();
        }
    }
}
