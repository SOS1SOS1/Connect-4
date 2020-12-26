//
//  GameScene.swift
//  Connect 4
//
//  Created by Shanti Mickens on 4/12/19.
//  Copyright © 2019 Shanti Mickens. All rights reserved.
//

import SpriteKit
import GameplayKit

var numPlayers = 1
var p1_Color = UIColor.red
var p2_Color = UIColor.yellow

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    // Player 1 - Color Choices
    let p1_color1 = SKShapeNode(circleOfRadius: 22)
    let p1_color2 = SKShapeNode(circleOfRadius: 22)
    let p1_color3 = SKShapeNode(circleOfRadius: 22)
    let p1_color4 = SKShapeNode(circleOfRadius: 22)
    
    // Player 2 - Computer Option / Color Choices
    let cpOption = SKSpriteNode(imageNamed: "computer")
    let p2_color1 = SKShapeNode(circleOfRadius: 22)
    let p2_color2 = SKShapeNode(circleOfRadius: 22)
    let p2_color3 = SKShapeNode(circleOfRadius: 22)
    
    // computer option image size
    var cpWidth : CGFloat = 0
    var cpHeight : CGFloat = 0
    
    // Start Game Button
    let startGame = SKShapeNode(rectOf: CGSize(width: 450, height: 100), cornerRadius: 5)
    
    override func didMove(to view: SKView) {
        
        // radius for color options
        let r = 20
        
        self.backgroundColor = UIColor.white
        
        let titleLabel = SKLabelNode(fontNamed: "The Bold Font")
        titleLabel.text = "Connect 4"
        titleLabel.fontSize = 125.0
        titleLabel.position = CGPoint(x: 0, y: 485)
        titleLabel.fontColor = #colorLiteral(red: 0.1803921569, green: 0.5254901961, blue: 0.7568627451, alpha: 1)
        addChild(titleLabel)
        
        // sets default player colors and number of players
        p1_Color = #colorLiteral(red: 0.9480952621, green: 0, blue: 0.01454990171, alpha: 1)
        numPlayers = 1
        p2_Color = #colorLiteral(red: 1, green: 0.914349854, blue: 0.2137838006, alpha: 1)
        // red: 1, green: 0.914349854, blue: 0.2137838006
        
        // Player 1 Color Selection
        let player1Options = SKLabelNode(fontNamed: "The Bold Font")
        player1Options.fontSize = 50.0
        player1Options.fontColor = UIColor.black
        player1Options.text = "Player 1 - "
        player1Options.position = CGPoint(x: -175, y: 50)
        addChild(player1Options)
        
        // red
        p1_color1.lineWidth = 15
        p1_color1.fillColor = #colorLiteral(red: 0.9480952621, green: 0, blue: 0.01454990171, alpha: 1)
        p1_color1.strokeColor = #colorLiteral(red: 0.9480952621, green: 0, blue: 0.01454990171, alpha: 1)
        p1_color1.position = CGPoint(x: 0, y: 52 + r/2)
        addChild(p1_color1)
        // blue
        p1_color2.fillColor = #colorLiteral(red: 0.3855426908, green: 0.8387874961, blue: 0.7940081358, alpha: 1)
        p1_color2.strokeColor = #colorLiteral(red: 0.3855426908, green: 0.8387874961, blue: 0.7940081358, alpha: 1)
        p1_color2.position = CGPoint(x: 85, y: 52 + r/2)
        addChild(p1_color2)
        // light green
        p1_color3.fillColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        p1_color3.strokeColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        p1_color3.position = CGPoint(x: 168, y: 52 + r/2)
        addChild(p1_color3)
        // pink
        p1_color4.fillColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        p1_color4.strokeColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        p1_color4.position = CGPoint(x: 250, y: 52 + r/2)
        addChild(p1_color4)
        
        // Player 2 Color Selection
        let player2Options = SKLabelNode(fontNamed: "The Bold Font")
        player2Options.fontSize = 50.0
        player2Options.fontColor = UIColor.black
        player2Options.text = "Player 2 - "
        player2Options.position = CGPoint(x: -175, y: -50)
        addChild(player2Options)
        
        // computer
        cpOption.position = CGPoint(x: 0, y: -35)
        cpWidth = cpOption.size.width
        cpHeight = cpOption.size.height
        cpOption.size.width = cpWidth + 15
        cpOption.size.height = cpHeight + 15
        addChild(cpOption)
        // dark yellow
        p2_color1.fillColor = #colorLiteral(red: 1, green: 0.914349854, blue: 0.2137838006, alpha: 1)
        p2_color1.strokeColor = #colorLiteral(red: 1, green: 0.914349854, blue: 0.2137838006, alpha: 1)
        p2_color1.position = CGPoint(x: 85, y: -48 + r/2)
        addChild(p2_color1)
        // orange
        p2_color2.fillColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        p2_color2.strokeColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        p2_color2.position = CGPoint(x: 168, y: -48 + r/2)
        addChild(p2_color2)
        // purple
        p2_color3.fillColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
        p2_color3.strokeColor = #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1)
        p2_color3.position = CGPoint(x: 249, y: -48 + r/2)
        addChild(p2_color3)
        
        // start game buttons/label
        let startGameLabel = SKLabelNode(fontNamed: "The Bold Font")
        startGameLabel.fontSize = 68.0
        startGameLabel.text = "Start Game"
        startGameLabel.position = CGPoint(x: 0, y: -300)
        addChild(startGameLabel)
        startGame.fillColor = #colorLiteral(red: 0.9480952621, green: 0, blue: 0.01454990171, alpha: 1)
        startGame.strokeColor = #colorLiteral(red: 0.9480952621, green: 0, blue: 0.01454990171, alpha: 1)
        startGame.position = CGPoint(x: 0, y: -300 + 25)
        addChild(startGame)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            
            let pointOfTouch = touch.location(in: self)
            
            // checks if an option for player 1 was pressed
            if (p1_color1.contains(pointOfTouch) || p1_color2.contains(pointOfTouch) || p1_color3.contains(pointOfTouch) || p1_color4.contains(pointOfTouch)) {
                
                p1_color1.lineWidth = 1
                p1_color2.lineWidth = 1
                p1_color3.lineWidth = 1
                p1_color4.lineWidth = 1
                
                if (p1_color1.contains(pointOfTouch)) {
                    p1_Color = p1_color1.fillColor
                    p1_color1.lineWidth = 15
                } else if (p1_color2.contains(pointOfTouch)) {
                    p1_Color = p1_color2.fillColor
                    p1_color2.lineWidth = 15
                } else if (p1_color3.contains(pointOfTouch)) {
                    p1_Color = p1_color3.fillColor
                    p1_color3.lineWidth = 15
                } else if (p1_color4.contains(pointOfTouch)) {
                    p1_Color = p1_color4.fillColor
                    p1_color4.lineWidth = 15
                }
            }
            
            // checks if an option for player 2 was pressed
            if (cpOption.contains(pointOfTouch) || p2_color1.contains(pointOfTouch) || p2_color2.contains(pointOfTouch) || p2_color3.contains(pointOfTouch)) {
                
                cpOption.size.width = cpWidth
                cpOption.size.height = cpHeight
                p2_color1.lineWidth = 1
                p2_color2.lineWidth = 1
                p2_color3.lineWidth = 1
                
                if (cpOption.contains(pointOfTouch)) {
                    numPlayers = 1
                    p2_Color = p2_color1.fillColor
                    cpOption.size.width = cpWidth + 12
                    cpOption.size.height = cpHeight + 12
                } else if (p2_color1.contains(pointOfTouch)) {
                    p2_Color = p2_color1.fillColor
                    p2_color1.lineWidth = 15
                    numPlayers = 2
                } else if (p2_color2.contains(pointOfTouch)) {
                    p2_Color = p2_color2.fillColor
                    p2_color2.lineWidth = 15
                    numPlayers = 2
                } else if (p2_color3.contains(pointOfTouch)) {
                    p2_Color = p2_color3.fillColor
                    p2_color3.lineWidth = 15
                    numPlayers = 2
                }
                
            }
            
            // starts the game when the start game button is pressed
            if (startGame.contains(pointOfTouch)) {
                
                // switches scenes to game grid scene
                let sceneToMoveTo = GameGridScene(size: CGSize(width: self.size.width, height: self.size.height))
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTransition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTransition)
                
            }
            
        }
        
    }
    
}
