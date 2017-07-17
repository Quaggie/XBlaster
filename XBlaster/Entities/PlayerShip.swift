//
//  PlayerShip.swift
//  XBlaster
//
//  Created by Jonathan Bijos on 12/07/17.
//  Copyright © 2017 Quaggie. All rights reserved.
//

import SpriteKit

class PlayerShip: Entity {
    
    init(entityPosition: CGPoint) {
        let entityTexture = PlayerShip.generateTexture()!
        super.init(position: entityPosition, texture: entityTexture)
        name = "playerShip"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func generateTexture() -> SKTexture? {
        
        struct SharedTexture {
            static var texture = SKTexture()
            static var onceToken = "playerShip"
        }
        
        DispatchQueue.once(token: SharedTexture.onceToken) {
            let mainShip = SKLabelNode(fontNamed: "Arial")
            mainShip.name = "mainShip"
            mainShip.fontSize = 40
            mainShip.fontColor = SKColor.white
            mainShip.text = "▲"
            
            let wings = SKLabelNode(fontNamed: "Arial")
            wings.name = "wings"
            wings.fontSize = 40
            wings.text = "< >"
            wings.fontColor = SKColor.white
            wings.position = CGPoint(x: 1, y: 7)
            wings.zRotation = CGFloat(180).degreesToRadians()
            
            mainShip.addChild(wings)
            
            let textureView = SKView()
            SharedTexture.texture = textureView.texture(from: mainShip)!
            SharedTexture.texture.filteringMode = .nearest
        }
        
        return SharedTexture.texture
    }
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    class func once(token: String, block: () -> ()) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}
