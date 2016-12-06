//
//  LevelSelect.swift
//  iTrials
//
//  Created by Chad on 12/5/16.
//  Copyright © 2016 student. All rights reserved.
//

import Foundation
import SpriteKit

class LevelSelectScene: SKScene{
    
    var sceneManager:SceneManager = GameViewController()
    
    // MARK: - Initialization -
    class func loadLevel(size: CGSize, scaleMode:SKSceneScaleMode, sceneManager:SceneManager) -> LevelSelectScene?{
        
        let scene = LevelSelectScene(fileNamed: "LevelSelectScene")!
        scene.size = size
        scene.scaleMode = scaleMode
        scene.sceneManager = sceneManager
        return scene
    }
    
    override func didMove(to view: SKView) {
        
        let buttonNode = SKSpriteNode(imageNamed: "ReturnToMain")
        
        let button:Button = Button(buttonNode)
        button.setup()
        button.position = CGPoint(x: 0, y: -420)
        button.subscribeToRelease(funcName: "onMainPressed", callback: onMainPressed)
        button.pressAnimation = SKAction.scale(by: 0.9, duration: 0.5)
        button.releaseAnimation = SKAction.scale(to: 1, duration: 0.5)
        addChild(button)
    }
    
    func onMainPressed(){
        sceneManager.loadHomeScene()
    }
}
