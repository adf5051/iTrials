//
//  GameScene.swift
//  iTrials
//
//  Created by student on 11/6/16.
//  Copyright © 2016 student. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene,UIGestureRecognizerDelegate, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!
    var dirtEmitter: SKEmitterNode!
    
    var levelNum:Int = 1
    var totalScore:Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(totalScore)"
        }
    }
    var sceneManager:SceneManager = GameViewController()
    var spritesMoving:Bool = false
    var gameLoopPaused:Bool = true{
        didSet{
            print("gameLoopPaused=\(gameLoopPaused)")
            gameLoopPaused ? runPauseAction() : runUnpauseAction()
        }
    }
    var lastUpdateTime:TimeInterval = 0
    var dt:TimeInterval = 0
    
    var gasDown:Bool = false
    var brakeDown:Bool = false
    var gameOver:Bool = false
    
    var car:Car!
    var carTop: SKSpriteNode!
    
    var playableRect:CGRect!
    
    // MARK: - Initialization -
    class func loadLevel(_ levelNum: Int, size: CGSize, scaleMode:SKSceneScaleMode, totalScore: Int, sceneManager:SceneManager) -> GameScene?{
        
        let scene = GameScene(fileNamed: "Level\(levelNum)")!
        scene.levelNum = levelNum
        scene.size = size
        scene.scaleMode = scaleMode
        scene.sceneManager = sceneManager
        scene.playableRect = GameData.getPlayableRect(game: scene)
        return scene
    }
    
    override func didMove(to view: SKView) {
        self.camera = childNode(withName: "//Camera") as! SKCameraNode?
        car = Car(scene: self)
        setupUI()
        setupSpritesAndPhysics()
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        // Called before each frame is rendered
        calculateDeltaTime(currentTime: currentTime)
        
        if gasDown {
            car.drive()
        }
        
        if brakeDown {
            car.reverse()
        }
    }
    
    // MARK: - Pause/Unpause -
    private func runPauseAction(){
        physicsWorld.speed = 0.0
        spritesMoving = false
        
        let fadeAction = SKAction.customAction(withDuration: 0.25,
            actionBlock:{
                node, elapsedTime in
                let totalAnimationTime:CGFloat = 0.5
                let percentDone = elapsedTime/totalAnimationTime
                let amountToFade:CGFloat = 0.5
                node.alpha = 1.0 - (percentDone * amountToFade)
            })
        
        let pauseAction = SKAction.run({
            self.view?.isPaused = true
        })
        
        let pauseViewAfterFadeAction = SKAction.sequence([
            fadeAction,
            pauseAction])
        
        run(pauseViewAfterFadeAction)
    }
    
    private func runUnpauseAction(){
        print(#function)
        view?.isPaused = false // resumes actions and update()
        lastUpdateTime = 0
        dt = 0
        spritesMoving = false // needed if called by Notification
        
        let unPauseAction = SKAction.sequence([
            SKAction.fadeIn(withDuration: 1.0),
            SKAction.run({
                self.physicsWorld.speed = 1.0 // resumes physics
                self.spritesMoving = true
            })
            ])
        unPauseAction.timingMode = .easeIn
        run(unPauseAction)
    }
    
    //MARK: - Helpers -
    
    private func calculateDeltaTime(currentTime: TimeInterval){
        
        if lastUpdateTime > 0{
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
    }
    
    private func setupUI(){
        scoreLabel = childNode(withName: "//scoreLabel") as! SKLabelNode!
        scoreLabel?.fontName = GameData.Font.mainFont
        
        let gasSprite = SKSpriteNode(imageNamed: "GasPedal")
        gasSprite.xScale = 1.5
        gasSprite.yScale = 1.5
        let brakeSprite = SKSpriteNode(imageNamed: "BrakePedal")
        brakeSprite.xScale = 1.5
        brakeSprite.yScale = 1.5
        
        let gasButton = Button(gasSprite)
        let brakeButton = Button(brakeSprite)
        
        //this will need to change to adapt to the origin of the scene later
        gasButton.position = CGPoint(x: size.width/2-gasSprite.size.width, y: -size.height/2 + gasSprite.size.height/2)
        brakeButton.position = CGPoint(x: -size.width/2 + brakeSprite.size.width, y: -size.height/2 + brakeSprite.size.height/2)
        
        gasButton.pressAnimation = SKAction.setTexture(SKTexture(imageNamed: "GasPedalPressed"))
        brakeButton.pressAnimation = SKAction.setTexture(SKTexture(imageNamed: "BrakePedalPressed"))
        
        gasButton.releaseAnimation = SKAction.setTexture(SKTexture(imageNamed: "GasPedal"))
        brakeButton.releaseAnimation = SKAction.setTexture(SKTexture(imageNamed: "BrakePedal"))
        
        gasButton.subscribeToPress(funcName: "onGasPressed", callback: onGasPressed)
        brakeButton.subscribeToPress(funcName: "onBrakePressed", callback: onBrakePressed)
        
        gasButton.subscribeToRelease(funcName: "onGasReleased", callback: onGasReleased)
        brakeButton.subscribeToRelease(funcName: "onBrakeReleased", callback: onBrakeReleased)
        
        camera?.addChild(gasButton)
        camera?.addChild(brakeButton)
        
        let restartSprite = SKSpriteNode(imageNamed: "redo")
        restartSprite.setScale(0.5)
        let restartButton = Button(restartSprite);
        restartButton.position = CGPoint(x:size.width/2-restartSprite.size.width, y: size.height/2 - restartSprite.size.height/2)
        restartButton.subscribeToRelease(funcName: "onRestartReleased", callback: onRestartReleased)
        restartButton.pressAnimation = SKAction.scale(by: 0.9, duration: 0.2)
        restartButton.releaseAnimation = SKAction.scale(to: 1, duration: 0.2)
        
        camera?.addChild(restartButton)
    }
    
    private func onRestartReleased() {
        sceneManager.loadGameScene(levelNum: levelNum, totalScore: 0)
    }
    
    private func onGasPressed() {
        //car.physicsBody?.applyImpulse(CGVector(dx: 100.0, dy: 0))
        if(gameOver != true){
            gasDown = true
        }
        print("GO!")
    }
    
    private func onGasReleased() {
        gasDown = false
        print("Gas Released")
    }
    
    private func onBrakePressed() {
        if(gameOver != true){
            brakeDown = true
        }
        print("STOP!")
    }
    
    private func onBrakeReleased() {
        brakeDown = false
        print("Brake Released")
    }
    
    private func setupSpritesAndPhysics(){
        physicsWorld.contactDelegate = self
        
        carTop = SKSpriteNode(color: SKColor.clear, size: car.carNode.size)
        carTop.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: car.carNode.position.x - (car.carNode.size.width/2), y: car.carNode.position.y + (car.carNode.size.height/2)), to: CGPoint(x: car.carNode.position.x + (car.carNode.size.width/2), y: car.carNode.position.y + (car.carNode.size.height/2)))
        carTop.physicsBody!.collisionBitMask = GameData.PhysicsCategory.Ground
        carTop.physicsBody!.categoryBitMask = GameData.PhysicsCategory.CarTop
        carTop.physicsBody!.contactTestBitMask = GameData.PhysicsCategory.Ground
        addChild(carTop)
        
        let finishLine = childNode(withName: "//finishLine") as! SKSpriteNode
        let finishSize = finishLine.size
        finishLine.physicsBody = SKPhysicsBody(rectangleOf: finishSize)
        finishLine.physicsBody!.isDynamic = false
        finishLine.physicsBody!.categoryBitMask = GameData.PhysicsCategory.Finish
        finishLine.physicsBody!.collisionBitMask = GameData.PhysicsCategory.None
        finishLine.physicsBody!.contactTestBitMask = GameData.PhysicsCategory.Car | GameData.PhysicsCategory.Wheels
        
        let ground = childNode(withName: "//ground") as! SKSpriteNode
        ground.physicsBody!.categoryBitMask = GameData.PhysicsCategory.Ground
        ground.physicsBody!.contactTestBitMask = GameData.PhysicsCategory.Wheels
        
        enumerateChildNodes(withName: "Coin_Ref", using: { node, _ in
            
            if let coinNode = node.childNode(withName: ".//Coin") as? CoinNode {
                coinNode.addedToScene(value: 10)
            }
        })
        
        dirtEmitter = SKEmitterNode(fileNamed: "Dirt")
        dirtEmitter.position = CGPoint(x: -90, y: -37)
        dirtEmitter.name = "Emitter"
    }
    
    override func didSimulatePhysics() {
        self.camera?.position = car.carNode.position
        carTop.position = CGPoint(x: car.carNode.position.x, y: car.carNode.position.y)
        carTop.zRotation = car.carNode.zRotation
    }
    
    // MARK: - Collision -
    func didBegin(_ contact: SKPhysicsContact){
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        guard gameOver != true else{
            return
        }
        
        if collision == GameData.PhysicsCategory.Wheels | GameData.PhysicsCategory.Finish{
            
            win()
        }
        else if collision == GameData.PhysicsCategory.CarTop | GameData.PhysicsCategory.Ground{
            
            lose()
        }
        else if collision == GameData.PhysicsCategory.Car | GameData.PhysicsCategory.PickUp
            || collision == GameData.PhysicsCategory.Wheels | GameData.PhysicsCategory.PickUp {
            
            if contact.bodyA.node?.name == "Coin"{
                let coin = contact.bodyA.node as! CoinNode
                totalScore += coin.value
                coin.removeFromParent()
            } else if contact.bodyB.node?.name == "Coin"{
                let coin = contact.bodyB.node as! CoinNode
                totalScore += coin.value
                coin.removeFromParent()
            }
        } 
    }
    
    // MARK: - Win/Lose -
    func win(){
        
        //show win screen
        print("Win!!")
        gameOver = true
        
        let winLabel = SKLabelNode(fontNamed: GameData.Font.mainFont)
        
        if(levelNum == GameData.Game.maxLevel){
            
            winLabel.text = "You Win!"
        }
        else{
            winLabel.text = "Level Finished!"
        }
        winLabel.fontSize = 120
        winLabel.position = CGPoint(x: (camera?.frame.width)! / 2, y: (camera?.frame.height)! / 2 + 100)
        winLabel.zPosition = GameData.GameLayer.message
        
        camera?.addChild(winLabel)
        
        let nextLabel = SKLabelNode(fontNamed: GameData.Font.mainFont)
        
        if(levelNum == GameData.Game.maxLevel){
            nextLabel.text = "Quit"
        }
        else{
            nextLabel.text = "Continue"
        }
        nextLabel.position = CGPoint(x: (camera?.frame.width)! / 2, y: (camera?.frame.height)! / 2 + 20)
        nextLabel.zPosition = GameData.GameLayer.message
        
        camera?.addChild(nextLabel)
        
        let buttonNode = SKShapeNode.init(rectOf: CGSize.init(width: 400, height: 100))
        
        buttonNode.lineWidth = 5
        buttonNode.strokeColor = SKColor.red
        buttonNode.fillColor = SKColor.black
        
        //label and buttons
        let button:Button = Button(buttonNode)
        button.setup();
        button.position = CGPoint(x: (camera?.frame.width)! / 2, y: (camera?.frame.height)! / 2 + 20)
        
        if levelNum == GameData.Game.maxLevel{
            button.subscribeToRelease(funcName: "homeScene", callback: homeScene)
        }
        else{
            button.subscribeToRelease(funcName: "nextLevel", callback: nextLevel)
        }
        button.pressAnimation = SKAction.scale(by: 0.7, duration: 1)
        button.releaseAnimation = SKAction.scale(to: 1, duration: 1)
        button.zPosition = GameData.GameLayer.hud
        camera?.addChild(button)
    }
    
    func lose(){
        
        //show lose screen
        print("Lose!!")
        gameOver = true
        let loseLabel = SKLabelNode(fontNamed: GameData.Font.mainFont)
        loseLabel.text = "Game Over"
        loseLabel.fontSize = 120
        loseLabel.position = CGPoint(x: (camera?.frame.width)! / 2, y: (camera?.frame.height)! / 2 + 100)
        loseLabel.zPosition = GameData.GameLayer.message
        
        camera?.addChild(loseLabel)
        
        let nextLabel = SKLabelNode(fontNamed: GameData.Font.mainFont)
        nextLabel.text = "Quit"
        nextLabel.fontSize = 60
        nextLabel.position = CGPoint(x: (camera?.frame.width)! / 2, y: (camera?.frame.height)! / 2 + 20)
        nextLabel.zPosition = GameData.GameLayer.message
        
        camera?.addChild(nextLabel)
        
        let buttonNode = SKShapeNode.init(rectOf: CGSize.init(width: 400, height: 100))
        
        buttonNode.lineWidth = 5
        buttonNode.strokeColor = SKColor.red
        buttonNode.fillColor = SKColor.black
        
        //label and buttons
        let button:Button = Button(buttonNode)
        button.setup();
        button.position = CGPoint(x: (camera?.frame.width)! / 2, y: (camera?.frame.height)! / 2 + 20)
        button.subscribeToRelease(funcName: "homeScene", callback: homeScene)
        button.pressAnimation = SKAction.scale(by: 0.7, duration: 1)
        button.releaseAnimation = SKAction.scale(to: 1, duration: 1)
        button.zPosition = GameData.GameLayer.hud
        camera?.addChild(button)
    }
    
    // load next level
    func nextLevel(){
        
        if(gameOver){
            sceneManager.loadGameScene(levelNum: levelNum + 1, totalScore: totalScore)
        }
    }
    
    // return to home screen
    func homeScene(){
        
        if(gameOver){
            sceneManager.loadHomeScene()
        }
    }
}
