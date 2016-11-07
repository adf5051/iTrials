//
//  GameViewController.swift
//  Galaba
//
//  Created by student on 9/20/16.
//  Copyright © 2016 student. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, SceneManager {
    
    // MARK - ivars -
    var gameScene: GameScene?
    var skView: SKView!
    let showDebugData = true
    let screenSize = CGSize(width: 1080, height: 1920)
    let scaleMode = SKSceneScaleMode.aspectFill
    
    // MARK - Initialization -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.becomeFirstResponder()
        skView = self.view as! SKView
        loadHomeScene()
        setupNotifications()
        
        // debug stuff
        skView.ignoresSiblingOrder = true
        skView.showsFPS = showDebugData
        skView.showsNodeCount = showDebugData
        print(#function)
    }
    
    // MARK - Scene Management -
    func loadHomeScene() {
        
        let scene = HomeScene.loadHome(size: screenSize, scaleMode: scaleMode, sceneManager: self)
        let reveal = SKTransition.crossFade(withDuration: 1)
        skView.presentScene(scene!, transition: reveal)
    }
    
    func loadGameScene(levelNum: Int, totalScore: Int) {
        
        gameScene = GameScene.loadLevel(levelNum,size:screenSize,scaleMode: scaleMode,totalScore: totalScore,sceneManager: self)
        
        let reveal = SKTransition.doorsOpenHorizontal(withDuration: 1)
        skView.presentScene(gameScene!, transition: reveal)
        
        MotionMonitor.sharedMotionMonitor.startUpdates()
    }
    
    func loadLevelFinishScene(results: LevelResults){
        
        gameScene = nil
        let scene = LevelFinishScene.loadFinish(size: screenSize, scaleMode: scaleMode, results: results, sceneManager: self)
        let reveal = SKTransition.crossFade(withDuration: 1)
        skView.presentScene(scene!, transition: reveal)
        
        MotionMonitor.sharedMotionMonitor.stopUpdates()
    }
    
    func loadGameOverScene(results: LevelResults){
        
        gameScene = nil
        let scene = GameOverScene.loadGameOver(size: screenSize, scaleMode: scaleMode, results: results, sceneManager: self)
        let reveal = SKTransition.crossFade(withDuration: 1)
        skView.presentScene(scene!, transition: reveal)
    }
    
    func loadCreditsScene() {
        //TODO: - needs implementation -
    }
    
    // MARK - Notifications -
    func setupNotifications(){
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(willResignActive),
            name: NSNotification.Name.UIApplicationWillResignActive,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didBecomeActive),
            name: NSNotification.Name.UIApplicationDidBecomeActive,
            object: nil)
    }
    
    func willResignActive(n:NSNotification){
        
        print(#function)
        MotionMonitor.sharedMotionMonitor.stopUpdates()
    }
    
    func didBecomeActive(n:NSNotification){
        
        print(#function)
        MotionMonitor.sharedMotionMonitor.startUpdates()
        gameScene?.gameLoopPaused = false
    }
    
    func teardownNotifications(){
        
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        teardownNotifications()
    }
    
    // MARK - Motion Events -
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        if motion == .motionShake {
            
            print("detected shake")
            //gameScene?.shake()
        }
    }
    
    // MARK - Lifecycle -
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // release any cached data, images, etc that aren't in use.
    }
    
    override var prefersStatusBarHidden: Bool {
        
        return true
    }
    
    override var canBecomeFirstResponder: Bool{
        
        return true
    }
}
