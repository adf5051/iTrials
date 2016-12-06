//
//  Level.swift
//  iTrials
//
//  Created by Chad on 12/6/16.
//  Copyright © 2016 student. All rights reserved.
//

import Foundation

class Level{
    
    private let levelNum:Int
    var name:String
    var completed:Bool
    
    init(levelNum: Int){
        self.levelNum = levelNum
        self.completed = false
        self.name = "Level\(levelNum)"
    }
}
