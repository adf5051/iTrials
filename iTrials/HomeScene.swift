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
        
        //label and buttons
    }
    
    // TODO: change this to be work when a bitton is hit maybe
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sceneManager.loadGameScene(levelNum: 1, totalScore: 0)
    }
}
