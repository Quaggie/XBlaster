//
//  Bullet.swift
//  XBlaster
//
//  Created by Jonathan Bijos on 12/07/17.
//  Copyright © 2017 Quaggie. All rights reserved.
//

import SpriteKit

class Bullet: Entity {
    init(entityPosition: CGPoint) {
        let entityTexture = Bullet.generateTexture()!
        super.init(position: entityPosition, texture: entityTexture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func generateTexture() -> SKTexture? {
        struct SharedTexture {
            static var texture = SKTexture()
            static var onceToken = "bullet"
        }
        
        DispatchQueue.once(token: SharedTexture.onceToken) {
            let bullet = SKLabelNode(fontNamed: "Arial")
            bullet.name = "bullet"
            bullet.fontSize = 40
            bullet.fontColor = SKColor.white
            bullet.text = "•"
            
            let textureView = SKView()
            SharedTexture.texture = textureView.texture(from: bullet)!
            SharedTexture.texture.filteringMode = .nearest
        }
        
        return SharedTexture.texture
    }
}
