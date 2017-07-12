//
//  Entity.swift
//  XBlaster
//
//  Created by Jonathan Bijos on 12/07/17.
//  Copyright © 2017 Quaggie. All rights reserved.
//

import SpriteKit

class Entity: SKSpriteNode {
    
    var direction = CGPoint.zero
    var health = 100.0
    var maxHealth = 100.0
    
    init(position: CGPoint, texture: SKTexture) {
        super.init(texture: texture, color: SKColor.white, size: texture.size())
        self.position = position
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func generateTexture() -> SKTexture? {
        // Overriden
        return nil
    }
    
    func update(delta: TimeInterval) {
        // Overriden
    }
}
