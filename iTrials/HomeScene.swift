//
//  HomeScene.swift
//  iTrials
//
//  Created by student on 11/6/16.
//  Copyright © 2016 student. All rights reserved.
//

import SpriteKit

class HomeScene: SKScene {
    
    var sceneManager:SceneManager = GameViewController()
    
    // MARK: - Initialization -
    class func loadHome(size: CGSize, scaleMode:SKSceneScaleMode, sceneManager:SceneManager) -> HomeScene?{
        
        let scene = HomeScene(fileNamed: "HomeScene")!
        scene.size = size
        scene.scaleMode = scaleMode
        scene.sceneManager = sceneManager
        return scene
    }
    
    override func didMove(to view: SKView) {
        
        let buttonNode = SKShapeNode.init(rectOf: CGSize.init(width: 100, height: 100))
        
        buttonNode.lineWidth = 5
        buttonNode.strokeColor = SKColor.red
        buttonNode.fillColor = SKColor.black
        
        //label and buttons
        let button:Button = Button(buttonNode)
        button.setup();
        button.position = CGPoint(x: 0, y: 0)
        //button.subscribeToPress(funcName: "buttonPressed", callback: buttonPressed)
        button.pressAnimation = SKAction.scale(by: 0.7, duration: 1)
        button.releaseAnimation = SKAction.scale(to: 1, duration: 1)
        addChild(button)
    }
    
    func buttonPressed() {
        sceneManager.loadGameScene(levelNum: 1, totalScore: 0)
    }
    
    // TODO: change this to be work when a bitton is hit maybe
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //sceneManager.loadGameScene(levelNum: 1, totalScore: 0)
    }
}
