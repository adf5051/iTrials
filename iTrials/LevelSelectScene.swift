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
        
        let level1ButtonNode = SKSpriteNode(imageNamed: "Level1Button")
        
        let level1Button:Button = Button(level1ButtonNode)
        level1Button.setup()
        level1Button.position = CGPoint(x: 0, y: 100)
        level1Button.subscribeToRelease(funcName: "onLevel1Pressed", callback: onLevel1Pressed)
        level1Button.pressAnimation = SKAction.scale(by: 0.9, duration: 0.5)
        level1Button.releaseAnimation = SKAction.scale(to: 1, duration: 0.5)
        addChild(level1Button)
        
        let level2ButtonNode = SKSpriteNode(imageNamed: "Level2Button")
        
        let level2Button:Button = Button(level2ButtonNode)
        level2Button.setup()
        level2Button.position = CGPoint(x: 0, y: -50)
        level2Button.subscribeToRelease(funcName: "onLevel2Pressed", callback: onLevel2Pressed)
        level2Button.pressAnimation = SKAction.scale(by: 0.9, duration: 0.5)
        level2Button.releaseAnimation = SKAction.scale(to: 1, duration: 0.5)
        addChild(level2Button)
        
        let level3ButtonNode = SKSpriteNode(imageNamed: "Level3Button")
        
        let level3Button:Button = Button(level3ButtonNode)
        level3Button.setup()
        level3Button.position = CGPoint(x: 0, y: -200)
        level3Button.subscribeToRelease(funcName: "onLevel3Pressed", callback: onLevel3Pressed)
        level3Button.pressAnimation = SKAction.scale(by: 0.9, duration: 0.5)
        level3Button.releaseAnimation = SKAction.scale(to: 1, duration: 0.5)
        addChild(level3Button)
    }
    
    func onMainPressed(){
        sceneManager.loadHomeScene()
    }
    
    func onLevel1Pressed(){
        sceneManager.loadGameScene(levelNum: 1, totalScore: 0)
    }
    
    func onLevel2Pressed(){
        sceneManager.loadGameScene(levelNum: 2, totalScore: 0)
    }
    
    func onLevel3Pressed(){
        sceneManager.loadGameScene(levelNum: 3, totalScore: 0)
    }
}
