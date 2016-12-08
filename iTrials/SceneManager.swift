//
//  SceneManager.swift
//  iTrials
//
//  Created by student on 11/6/16.
//  Copyright © 2016 student. All rights reserved.
//

import Foundation

protocol SceneManager {
    
    func loadHomeScene()
    func loadGameScene(levelNum:Int, totalScore:Int)
    func loadLevelFinishScene(results:LevelResults)
    func loadGameOverScene(results:LevelResults)
    func loadCreditsScene()
    func loadLevelSelectScene()
}
