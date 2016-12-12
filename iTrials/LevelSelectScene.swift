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
        buttonNode.setScale(1.5)
        
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
        level1Button.position = CGPoint(x: -200, y: 100)
        level1Button.subscribeToRelease(funcName: "onLevel1Pressed", callback: onLevel1Pressed)
        level1Button.pressAnimation = SKAction.scale(by: 0.9, duration: 0.5)
        level1Button.releaseAnimation = SKAction.scale(to: 1, duration: 0.5)
        addChild(level1Button)
        
        let level2ButtonNode = SKSpriteNode(imageNamed: "Level2Button")
        
        let level2Button:Button = Button(level2ButtonNode)
        level2Button.position = CGPoint(x: -200, y: -50)
        
        if GameData.Game.level2.locked{
            level2Button.alpha = 0.5
        }else{
            level2Button.setup()
            level2Button.subscribeToRelease(funcName: "onLevel2Pressed", callback: onLevel2Pressed)
            level2Button.pressAnimation = SKAction.scale(by: 0.9, duration: 0.5)
            level2Button.releaseAnimation = SKAction.scale(to: 1, duration: 0.5)
        }
        addChild(level2Button)
        
        let level3ButtonNode = SKSpriteNode(imageNamed: "Level3Button")
        
        let level3Button:Button = Button(level3ButtonNode)
        level3Button.position = CGPoint(x: -200, y: -200)
        
        if GameData.Game.level3.locked{
            level3Button.alpha = 0.5
        }else{
            level3Button.setup()
            level3Button.subscribeToRelease(funcName: "onLevel3Pressed", callback: onLevel3Pressed)
            level3Button.pressAnimation = SKAction.scale(by: 0.9, duration: 0.5)
            level3Button.releaseAnimation = SKAction.scale(to: 1, duration: 0.5)
        }
        addChild(level3Button)
        
        let level4ButtonNode = SKSpriteNode(imageNamed: "Level3Button")
        
        let level4Button:Button = Button(level4ButtonNode)
        level4Button.position = CGPoint(x: 200, y: 100)
        
        if GameData.Game.level4.locked{
            level4Button.alpha = 0.5
        }else{
            level4Button.setup()
            level4Button.subscribeToRelease(funcName: "onLevel4Pressed", callback: onLevel4Pressed)
            level4Button.pressAnimation = SKAction.scale(by: 0.9, duration: 0.5)
            level4Button.releaseAnimation = SKAction.scale(to: 1, duration: 0.5)
        }
        addChild(level4Button)
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
    
    func onLevel4Pressed(){
        sceneManager.loadGameScene(levelNum: 4, totalScore: 0)
    }
}
