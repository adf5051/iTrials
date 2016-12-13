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
        
        //let playGameButtonSprite:SKNode = childNode(withName: "PlayGameButton")!
        //let playGameButton = Button(playGameButtonSprite)
//        playGameButton.setup()
//        playGameButton.subscribeToRelease(funcName: "onPlayGamePressed", callback: onPlayGamePressed)
        
//        let buttonNode = SKShapeNode.init(rectOf: CGSize.init(width: 400, height: 100))
//        
//        buttonNode.lineWidth = 5
//        buttonNode.strokeColor = SKColor.red
//        buttonNode.fillColor = SKColor.black
        
        
        let buttonNode = SKSpriteNode(imageNamed: "EnterGame")
        buttonNode.setScale(1.5)
        
        //label and buttons
        let button:Button = Button(buttonNode)
        button.setup();

        button.position = CGPoint(x: size.width/2, y: size.width/2 - 400)

        button.subscribeToRelease(funcName: "onPlayGamePressed", callback: onPlayGamePressed)
        button.pressAnimation = SKAction.scale(by: 0.9, duration: 0.5)
        button.releaseAnimation = SKAction.scale(to: 1, duration: 0.5)
        addChild(button)
        
        let levelSelectButtonNode = SKSpriteNode(imageNamed: "LevelSelectButton")
        levelSelectButtonNode.setScale(1.5)
        
        let levelSelectButton:Button = Button(levelSelectButtonNode)
        levelSelectButton.setup();
        levelSelectButton.position = CGPoint(x: size.width/2, y: button.position.y - 150)
        levelSelectButton.subscribeToRelease(funcName: "onLevelSelectPressed", callback: onLevelSelectPressed)
        levelSelectButton.pressAnimation = SKAction.scale(by: 0.9, duration: 0.5)
        levelSelectButton.releaseAnimation = SKAction.scale(to: 1, duration: 0.5)
        addChild(levelSelectButton)
        
        let insButtonNode = SKSpriteNode(imageNamed: "Instruction_button")
        insButtonNode.setScale(1.5)
        
        let insButton:Button = Button(insButtonNode)
        insButton.setup()
        insButton.position = CGPoint(x: button.position.x, y: button.position.y - 300)
        insButton.subscribeToRelease(funcName: "onInstructionPressed", callback: onInstructionPressed)
        insButton.pressAnimation = SKAction.scale(by: 0.9, duration: 0.5)
        insButton.releaseAnimation = SKAction.scale(to: 1, duration: 0.5)
        addChild(insButton)
        
//        let label:SKLabelNode = SKLabelNode(fontNamed: GameData.Font.mainFont)
//        label.text = "Start"
//        label.position = button.position
//        label.zPosition = 10
//        label.fontSize = 60
//        label.fontColor = UIColor.white
//        addChild(label)
    }
    
    func onPlayGamePressed() {
        sceneManager.loadGameScene(levelNum: 1, totalScore: 0)
    }
    
    func onInstructionPressed(){
        sceneManager.loadCreditsScene()
    }
    
    func onLevelSelectPressed(){
        sceneManager.loadLevelSelectScene()
    }
    
    // TODO: change this to be work when a bitton is hit maybe
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //sceneManager.loadGameScene(levelNum: 1, totalScore: 0)
    }
}
