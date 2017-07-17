//
//  GameScene.swift
//  XBlaster
//
//  Created by Jonathan Bijos on 12/07/17.
//  Copyright © 2017 Quaggie. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let playerLayerNode = SKNode()
    let hudLayerNode = SKNode()
    let bulletLayerNode = SKNode()
    
    let scoreLabel = SKLabelNode(fontNamed: "Edit Undo Line BRK")
    var scoreFlashAction: SKAction!
    
    let healthBarString = "===================="
    let playerHealthLabel = SKLabelNode(fontNamed: "Arial")
    
    var playerShip: PlayerShip!
    
    let playableRect: CGRect
    let hudHeight: CGFloat = 90
    var deltaPoint = CGPoint.zero
    
    var bulletInterval: TimeInterval = 0
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(size: CGSize) {
        // Calculate playable margin
        let maxAspectRatio: CGFloat = 16.0 / 9.0 // iPhone 5"
        let maxAspectRatioWidth = size.height / maxAspectRatio
        let playableMargin = (size.width - maxAspectRatioWidth) / 2.0
        playableRect = CGRect(x: playableMargin,
                              y: 0,
                              width: size.width - playableMargin / 2,
                              height: size.height - hudHeight)
        
        super.init(size: size)
        
        setupSceneLayers()
        setupUI()
        setupEntities()
    }
    
    override func didMove(to view: SKView) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        var newPoint: CGPoint = playerShip.position + deltaPoint
        _ = newPoint.x.clamp(playableRect.minX, playableRect.maxX)
        _ = newPoint.y.clamp(playableRect.minY, playableRect.maxY)
        
        playerShip.position = newPoint
        deltaPoint = .zero
        
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
        
        bulletInterval += dt
        if bulletInterval > 0.15 {
            bulletInterval = 0
            
            let bullet = Bullet(entityPosition: playerShip.position)
            addChild(bullet)
            
            let moveBulletAction = SKAction.moveBy(x: 0, y: size.height, duration: 1.0)
            let removeBulletAction = SKAction.removeFromParent()
            let bulletAction = SKAction.sequence([moveBulletAction, removeBulletAction])
            bullet.run(bulletAction)
        }
    }
}

// MARK: Touches
extension GameScene {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            let previousTouchLocation = touch.previousLocation(in: self)
            deltaPoint = currentPoint - previousTouchLocation
        }
    }
}

// MARK: UI
extension GameScene {
    func setupSceneLayers() {
        playerLayerNode.zPosition = 50
        hudLayerNode.zPosition = 100
        bulletLayerNode.zPosition = 25
        
        addChild(playerLayerNode)
        addChild(hudLayerNode)
        addChild(bulletLayerNode)
    }
    
    func setupUI() {
        let backgroundSize = CGSize(width: size.width, height: hudHeight)
        let backgroundColor = SKColor.black
        let hudBarBackground = SKSpriteNode(color: backgroundColor, size: backgroundSize)
        hudBarBackground.position = CGPoint(x: 0, y: size.height - hudHeight)
        hudBarBackground.anchorPoint = .zero
        hudLayerNode.addChild(hudBarBackground)
        
        scoreLabel.fontSize = 50
        scoreLabel.text = "Score: 0"
        scoreLabel.name = "scoreLabel"
        scoreLabel.verticalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: size.width / 2,
                                      y: size.height - scoreLabel.frame.size.height + 3)
        
        hudLayerNode.addChild(scoreLabel)
        
        scoreFlashAction = SKAction.sequence([
            SKAction.scale(to: 1.5, duration: 0.1),
            SKAction.scale(to: 1.0, duration: 0.1)])
        scoreLabel.run(SKAction.repeat(scoreFlashAction, count: 20))
        
        let playerHealthBackgroundLabel = SKLabelNode(fontNamed: "Arial")
        playerHealthBackgroundLabel.name = "playerHealthBackground"
        playerHealthBackgroundLabel.fontColor = SKColor.darkGray
        playerHealthBackgroundLabel.fontSize = 50
        playerHealthBackgroundLabel.text = healthBarString
        playerHealthBackgroundLabel.horizontalAlignmentMode = .left
        playerHealthBackgroundLabel.verticalAlignmentMode = .top
        playerHealthBackgroundLabel.position = CGPoint(
            x: playableRect.minX,
            y: size.height - CGFloat(hudHeight) + playerHealthBackgroundLabel.frame.size.height)
        
        hudLayerNode.addChild(playerHealthBackgroundLabel)
        
        playerHealthLabel.name = "playerHealthLabel"
        playerHealthLabel.fontColor = SKColor.green
        playerHealthLabel.fontSize = 50
        let playerTotal = 20
        let playerPercent = 74
        var playerHealth = ""
        for _ in 1...Int(playerTotal * playerPercent / 100) {
            playerHealth.append("=")
        }
        playerHealthLabel.text = playerHealth
        playerHealthLabel.horizontalAlignmentMode = .left
        playerHealthLabel.verticalAlignmentMode = .top
        playerHealthLabel.position = CGPoint(
            x: playableRect.minX,
            y: size.height - CGFloat(hudHeight) + playerHealthLabel.frame.size.height)
        
        hudLayerNode.addChild(playerHealthLabel)
    }
    
    func setupEntities() {
        playerShip = PlayerShip(entityPosition: CGPoint(x: size.width / 2, y: 100))
        playerLayerNode.addChild(playerShip)
    }
}











