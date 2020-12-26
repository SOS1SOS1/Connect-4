//
//  GameGridScene.swift
//  Connect 4
//
//  Created by Shanti Mickens on 4/12/19.
//  Copyright © 2019 Shanti Mickens. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameGridScene: SKScene {
    
    // game title and player turn labels
    let titleLabel = SKLabelNode(fontNamed: "The Bold Font")
    let turnLabel = SKLabelNode(fontNamed: "The Bold Font")
    
    // home/restart buttons and labels
    let homeLabel = SKLabelNode(fontNamed: "The Bold Font")
    let home = SKShapeNode(rectOf: CGSize(width: 240, height: 75), cornerRadius: 5)
    let restartLabel = SKLabelNode(fontNamed: "The Bold Font")
    let restart = SKShapeNode(rectOf: CGSize(width: 325, height: 75), cornerRadius: 5)
    
    // true when it is player 1s turn and false when it is player 2 or the computers turn
    var player1Turn = true
    
    // array of pixels for center of grid spaces (column by row)
    var columns : [Int] = [-300, -200, -100, 0, 100, 200, 300]
    var rows : [Int] = [130, 30, -70, -170, -270, -370]
    
    // array of grid spaces: 0 means it is empty, 1 means it's p1 piece, 2 means it's p2 piece
    var grid : [[Int]] = [[Int]]()
    
    // starts out false, becomes true when someones wins or if there's a tie
    var gameOver = false
    
    //sets up the scene
    override init(size: CGSize) {
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.white
        player1Turn = true
        
        titleLabel.text = "Connect 4"
        titleLabel.fontSize = 125.0
        titleLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 485)
        titleLabel.fontColor = #colorLiteral(red: 0.1803921569, green: 0.5254901961, blue: 0.7568627451, alpha: 1)
        addChild(titleLabel)
        
        turnLabel.text = "Turn: Player 1"
        turnLabel.fontSize = 54.0
        turnLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 350)
        turnLabel.fontColor = UIColor.black
        addChild(turnLabel)
        
        // adds lines to screen
        createLines()
        
        // sets up grid variables as a 7 x 6 array of false values since no one has made a move yet
        for _ in 1...6 {
            grid.append([0, 0, 0, 0, 0, 0, 0])
        }
        
        // home button/label
        homeLabel.fontSize = 68.0
        homeLabel.text = "Home"
        homeLabel.position = CGPoint(x: self.size.width/2 - 185, y: 100)
        homeLabel.isHidden = true
        
        addChild(homeLabel)
        home.position = CGPoint(x: self.size.width/2 - 185, y: 128)
        home.isHidden = true
        addChild(home)
        
        // restart button/label
        restartLabel.fontSize = 68.0
        restartLabel.text = "Restart"
        restartLabel.position = CGPoint(x: self.size.width/2 + 140, y: 100)
        restartLabel.isHidden = true
        addChild(restartLabel)
        restart.position = CGPoint(x: self.size.width/2 + 140, y: 128)
        restart.isHidden = true
        addChild(restart)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            if (gameOver == false) {
                
                if ((numPlayers == 1 && player1Turn == true) || (numPlayers == 2)) {
                    
                    if (pointOfTouch.y > self.size.height/2 - 425 && pointOfTouch.y < self.size.height/2 + 300) {
                        if (pointOfTouch.x > self.size.width/2 - 350 && pointOfTouch.x < self.size.width/2 - 250) {
                            // column 1
                            placePiece(col: 0)
                        } else if (pointOfTouch.x > self.size.width/2 - 250 && pointOfTouch.x < self.size.width/2 - 150) {
                            // column 2
                            placePiece(col: 1)
                        } else if (pointOfTouch.x > self.size.width/2 - 150 && pointOfTouch.x < self.size.width/2 - 50) {
                            // column 3
                            placePiece(col: 2)
                        } else if (pointOfTouch.x > self.size.width/2 - 50 && pointOfTouch.x < self.size.width/2 + 50) {
                            // column 4
                            placePiece(col: 3)
                        } else if (pointOfTouch.x > self.size.width/2 + 50 && pointOfTouch.x < self.size.width/2 + 150) {
                            // column 5
                            placePiece(col: 4)
                        } else if (pointOfTouch.x > self.size.width/2 + 150 && pointOfTouch.x < self.size.width/2 + 250) {
                            // column 6
                            placePiece(col: 5)
                        } else if (pointOfTouch.x > self.size.width/2 + 250 && pointOfTouch.x < self.size.width/2 + 350) {
                            // column 7
                            placePiece(col: 6)
                        }
                    }
                    
                }
                
            }
            
            // returns to home screen
            if (home.contains(pointOfTouch)) {
                // switches scenes to game grid scene
                let sceneToMoveTo = GameScene(size: CGSize(width: self.size.width, height: self.size.height))
                sceneToMoveTo.scaleMode = self.scaleMode
                sceneToMoveTo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
            // restarts game with current settings
            if (restart.contains(pointOfTouch)) {
                // switches scenes to game grid scene
                let sceneToMoveTo = GameGridScene(size: CGSize(width: self.size.width, height: self.size.height))
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
            }
            
        }
        
    }
    
    func placePiece(col: Int) {
        let nextPiece = SKShapeNode(circleOfRadius: 48)
        let fade = SKAction.fadeIn(withDuration: 0.75)
        
        if (player1Turn) {
            // sets next pieces color
            nextPiece.fillColor = p1_Color
            nextPiece.strokeColor = p1_Color
            // checks for open space in column
            var row = 5
            while row >= 0 {
                if (grid[row][col] == 0) {
                    // sets next piece position to top of the clicked column
                    nextPiece.position = CGPoint(x: self.size.width/2 + CGFloat(columns[col]), y: self.size.height/2 + 235)
                    addChild(nextPiece)
                    
                    // creates piece falling down animation
                    let fallDown = SKAction.moveTo(y: self.size.height/2 + CGFloat(rows[row]), duration: 1.0)
                    nextPiece.run(fade)
                    nextPiece.run(fallDown)
                    
                    // sets variable at that space equal to 1 since it has player 2's game piece
                    grid[row][col] = 1
                    // changes to false since player one just went
                    player1Turn = false
                    
                    // updates turn label text on screen
                    if (numPlayers == 1) {
                        turnLabel.text = "Turn: Computer"
                    } else {
                        turnLabel.text = "Turn: Player 2"
                    }
                    
                    // checks if player 1 won
                    checkForFourInARow(player: 1)
                    
                    break
                }
                row -= 1
            }
            
            // checks if player 1 made a move and if the number of player is 1
            if (player1Turn == false && numPlayers == 1 && gameOver == false) {
                // 1 Player Mode - computer's turn
                var randCol = 0
                var placed = false
                
                // checks for open space in column
                var row = 5
                while placed == false {
                    row = 5
                    randCol = Int(arc4random_uniform(7))  // picks random column number from 0 to 6
                    while row >= 0 {
                        if (grid[row][randCol] == 0) {
                            placed = true
                            // creates the computer's game piece
                            let compPiece = SKShapeNode(circleOfRadius: 48)
                            
                            // sets next piece position to top of the clicked column
                            compPiece.position = CGPoint(x: self.size.width/2 + CGFloat(columns[randCol]), y: self.size.height/2 + 235)
                            compPiece.strokeColor = UIColor.clear
                            addChild(compPiece)
                            
                            // creates delay and piece falling down animation
                            let delay = SKAction.wait(forDuration: 0.75)
                            let showPiece = SKAction.run {
                                // sets it color to p2's color
                                compPiece.fillColor = p2_Color
                                compPiece.strokeColor = p2_Color
                                
                                // changes to true since computer just went
                                self.player1Turn = true
                                
                                // updates turn label text on screen
                                self.turnLabel.text = "Turn: Player 1"
                            }
                            let fallDown = SKAction.moveTo(y: self.size.height/2 + CGFloat(rows[row]), duration: 1.0)
                            let fadeAndFall = SKAction.group([fade, fallDown])
                            let waitThenShow = SKAction.sequence([delay, showPiece, fadeAndFall])
                            compPiece.run(waitThenShow)
                            
                            // sets variable at that space equal to 1 since it has player 2's game piece
                            grid[row][randCol] = 2
                            
                            // checks if computer won
                            checkForFourInARow(player: 2)
                            
                            break
                        }
                        row -= 1
                    }
                }
            }
            
        } else {
            // sets next pieces color
            nextPiece.fillColor = p2_Color
            nextPiece.strokeColor = p2_Color
            // checks for open space in column
            var row = 5
            while row >= 0 {
                if (grid[row][col] == 0) {
                    // sets next piece position to top of the clicked column
                    nextPiece.position = CGPoint(x: self.size.width/2 + CGFloat(columns[col]), y: self.size.height/2 + 235)
                    addChild(nextPiece)
                    
                    // creates piece falling down animation
                    let fallDown = SKAction.moveTo(y: self.size.height/2 + CGFloat(rows[row]), duration: 1.0)
                    nextPiece.run(fade)
                    nextPiece.run(fallDown)
                    
                    // sets variable at that space equal to 2 since it has player 2's game piece
                    grid[row][col] = 2
                    // changes to true since it is now player 1 turn again
                    player1Turn = true
                    // updates turn label text on screen
                    turnLabel.text = "Turn: Player 1"
                    
                    // checks if player 2 won
                    checkForFourInARow(player: 2)
                    
                    break
                }
                row -= 1
            }
        }
    }
    
    func checkForFourInARow(player: Int) {
        var fourInARow = true
        var index = 0
        
        // path of line that connects the winning pieces
        let path = CGMutablePath()
        
        // looks for horizontal four in a row
        for row in 0...5 {
            for col in 0...3 {
                fourInARow = true
                index = col
                for _ in 1...4 {
                    if (grid[row][index] != player) {
                        fourInARow = false
                    }
                    index += 1
                }
                if (fourInARow == true) {
                    print("1 Player \(player) Won!")
                    
                    // creates path to connect 4 pieces
                    path.move(to: CGPoint(x: self.size.width/2 + CGFloat(columns[col]), y: self.size.height/2 + CGFloat(rows[row])))
                    path.addLine(to: CGPoint(x: self.size.width/2 + CGFloat(columns[col+3]), y: self.size.height/2 + CGFloat(rows[row])))
                    
                    gameOver = true
                }
            }
        }
        
        // looks for vertical four in a row
        for col in 0...6 {
            for row in 0...2 {
                fourInARow = true
                index = row
                for _ in 1...4 {
                    if (grid[index][col] != player) {
                        fourInARow = false
                    }
                    index += 1
                }
                if (fourInARow == true) {
                    print("2 Player \(player) Won!")
                    
                    // creates path to connect 4 pieces
                    path.move(to: CGPoint(x: self.size.width/2 + CGFloat(columns[col]), y: self.size.height/2 + CGFloat(rows[row])))
                    path.addLine(to: CGPoint(x: self.size.width/2 + CGFloat(columns[col]), y: self.size.height/2 + CGFloat(rows[row+3])))
                    
                    gameOver = true
                }
            }
        }
        
        // looks for diagonal win (\)
        for row in 0...2 {
            for col in 0...3 {
                fourInARow = true
                for i in 0...3 {
                    if (grid[row + i][col + i] != player) {
                        fourInARow = false
                    }
                }
                if (fourInARow == true) {
                    print("3 Player \(player) Won!")
                    
                    // creates path to connect 4 pieces
                    path.move(to: CGPoint(x: self.size.width/2 + CGFloat(columns[col]), y: self.size.height/2 + CGFloat(rows[row])))
                    path.addLine(to: CGPoint(x: self.size.width/2 + CGFloat(columns[col+3]), y: self.size.height/2 + CGFloat(rows[row+3])))
                    
                    gameOver = true
                }
            }
        }
        
        // looks for diagonal win (/)
        for row in 0...2 {
            for col in 3...6 {
                fourInARow = true
                for i in 0...3 {
                    if (grid[row + i][col - i] != player) {
                        fourInARow = false
                    }
                }
                if (fourInARow == true) {
                    print("4 Player \(player) Won!")
                    
                    // creates path to connect 4 pieces
                    path.move(to: CGPoint(x: self.size.width/2 + CGFloat(columns[col]), y: self.size.height/2 + CGFloat(rows[row])))
                    path.addLine(to: CGPoint(x: self.size.width/2 + CGFloat(columns[col-3]), y: self.size.height/2 + CGFloat(rows[row+3])))
                    
                    gameOver = true
                }
            }
        }
        
        // looks for a tie
        if (gameOver == false) {
            var allFull = true
            for row in 0...5 {
                for col in 0...6 {
                    // checks if any spaces are empty
                    if (grid[row][col] == 0) {
                        allFull = false
                        break
                    }
                }
            }
            if (allFull == true) {
                // tie
                print("You tied!")
                turnLabel.text  = "You tied!"
                gameOver = true
            }
            
        } else {
            // makes winner/tie message bigger
            
            let wait = SKAction.wait(forDuration: 1.0)
            let showMessage = SKAction.run {
                self.turnLabel.fontSize = 70.0
                self.turnLabel.text  = "Player \(player) Won!"
                
                let line = SKShapeNode(path: path)
                line.lineWidth = 15
            
                // show home and restart buttons
                if (player == 1) {
                    self.turnLabel.fontColor = p1_Color
                    line.strokeColor = p1_Color
                    
                    if (p2_Color != #colorLiteral(red: 1, green: 0.914349854, blue: 0.2137838006, alpha: 1)) {
                        self.home.fillColor = p2_Color
                        self.home.strokeColor = p2_Color
                        self.restart.fillColor = p2_Color
                        self.restart.strokeColor = p2_Color
                    } else {
                        self.home.fillColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                        self.home.strokeColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                        self.restart.fillColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                        self.restart.strokeColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
                    }
                } else {
                    self.turnLabel.fontColor = p2_Color
                    line.strokeColor = p2_Color
                    
                    self.home.fillColor = p1_Color
                    self.home.strokeColor = p1_Color
                    self.restart.fillColor = p1_Color
                    self.restart.strokeColor = p1_Color
                }
            
                self.home.isHidden = false
                self.homeLabel.isHidden = false
                self.restart.isHidden = false
                self.restartLabel.isHidden = false
                
                self.addChild(line)
            }
            
            let waitThenShow = SKAction.sequence([wait, showMessage])
            self.run(waitThenShow)
        }
        
    }
    
    func createLines() {
        let path1 = CGMutablePath()
        path1.move(to: CGPoint(x: self.size.width/2 - 350, y: self.size.height/2 + 275))
        path1.addLine(to: CGPoint(x: self.size.width/2 - 350, y: self.size.height/2 + 200))
        let line1 = SKShapeNode(path: path1)
        line1.strokeColor = UIColor.lightGray
        line1.lineWidth = 3
        addChild(line1)
        
        let path2 = CGMutablePath()
        path2.move(to: CGPoint(x: self.size.width/2 - 250, y: self.size.height/2 + 275))
        path2.addLine(to: CGPoint(x: self.size.width/2 - 250, y: self.size.height/2 + 200))
        let line2 = SKShapeNode(path: path2)
        line2.strokeColor = UIColor.lightGray
        line2.lineWidth = 3
        addChild(line2)
        
        let path3 = CGMutablePath()
        path3.move(to: CGPoint(x: self.size.width/2 - 150, y: self.size.height/2 + 275))
        path3.addLine(to: CGPoint(x: self.size.width/2 - 150, y: self.size.height/2 + 200))
        let line3 = SKShapeNode(path: path3)
        line3.strokeColor = UIColor.lightGray
        line3.lineWidth = 3
        addChild(line3)
        
        let path4 = CGMutablePath()
        path4.move(to: CGPoint(x: self.size.width/2 - 50, y: self.size.height/2 + 275))
        path4.addLine(to: CGPoint(x: self.size.width/2 - 50, y: self.size.height/2 + 200))
        let line4 = SKShapeNode(path: path4)
        line4.strokeColor = UIColor.lightGray
        line4.lineWidth = 3
        addChild(line4)
        
        let path5 = CGMutablePath()
        path5.move(to: CGPoint(x: self.size.width/2 + 50, y: self.size.height/2 + 275))
        path5.addLine(to: CGPoint(x: self.size.width/2 + 50, y: self.size.height/2 + 200))
        let line5 = SKShapeNode(path: path5)
        line5.strokeColor = UIColor.lightGray
        line5.lineWidth = 3
        addChild(line5)
        
        let path6 = CGMutablePath()
        path6.move(to: CGPoint(x: self.size.width/2 + 150, y: self.size.height/2 + 275))
        path6.addLine(to: CGPoint(x: self.size.width/2 + 150, y: self.size.height/2 + 200))
        let line6 = SKShapeNode(path: path6)
        line6.strokeColor = UIColor.lightGray
        line6.lineWidth = 3
        addChild(line6)
        
        let path7 = CGMutablePath()
        path7.move(to: CGPoint(x: self.size.width/2 + 250, y: self.size.height/2 + 275))
        path7.addLine(to: CGPoint(x: self.size.width/2 + 250, y: self.size.height/2 + 200))
        let line7 = SKShapeNode(path: path7)
        line7.strokeColor = UIColor.lightGray
        line7.lineWidth = 3
        addChild(line7)
        
        let path8 = CGMutablePath()
        path8.move(to: CGPoint(x: self.size.width/2 + 350, y: self.size.height/2 + 275))
        path8.addLine(to: CGPoint(x: self.size.width/2 + 350, y: self.size.height/2 + 200))
        let line8 = SKShapeNode(path: path8)
        line8.strokeColor = UIColor.lightGray
        line8.lineWidth = 3
        addChild(line8)
        
        // adds bottom line
        let path9 = CGMutablePath()
        path9.move(to: CGPoint(x: 25, y: self.size.height/2 - 425))
        path9.addLine(to: CGPoint(x: self.size.width - 25, y: self.size.height/2 - 425))
        let line9 = SKShapeNode(path: path9)
        line9.strokeColor = UIColor.lightGray
        line9.lineWidth = 3
        addChild(line9)
    }
    
}
