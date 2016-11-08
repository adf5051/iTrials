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

class Button: SKShapeNode {
    
    private var pressCallbacks:[String:()->()] = [:]
    private var releaseCallbacks:[String:()->()] = [:]
    
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
    
    override init(){
        super.init();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(view: SKView) {
        self.isUserInteractionEnabled = true;
    }
    
    public func setup(view: SKView, size:CGSize, lineWidth:CGFloat, strokeColor:SKColor, fillColor:SKColor) {
        path = SKShapeNode.init(rectOf: size).path;
        self.strokeColor = strokeColor
        self.lineWidth = lineWidth
        self.fillColor = fillColor
    }
    
    // should not need to detect where, this should only be called when the sprite is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //var touch = touches.first
        print("TOUCH")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("TOUCH ENDED")
    }
    
    func firePressCallbacks(){
        for (_,callback) in pressCallbacks {
            callback();
        }
    }
    
    func fireReleaseCallbacks(){
        for (_,callback) in releaseCallbacks {
            callback();
        }
    }
}
