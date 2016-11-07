//
//  GameOverScene.swift
//  iTrials
//
//  Created by student on 11/6/16.
//  Copyright © 2016 student. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    
    var sceneManager:SceneManager = GameViewController()
    var results:LevelResults!
    
    // MARK: - Initialization -
    class func loadGameOver(size: CGSize, scaleMode:SKSceneScaleMode, results: LevelResults, sceneManager:SceneManager) -> GameOverScene?{
        
        let scene = GameOverScene(fileNamed: "GameOverScene")!
        scene.size = size
        scene.scaleMode = scaleMode
        scene.results = results
        scene.sceneManager = sceneManager
        return scene
    }
    
    override func didMove(to view: SKView) {
        
        //label and buttons
    }
    
    // TODO: change this to be work when a bitton is hit maybe
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneManager.loadHomeScene()
    }
}
