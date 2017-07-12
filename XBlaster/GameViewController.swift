//
//  GameViewController.swift
//  XBlaster
//
//  Created by Jonathan Bijos on 12/07/17.
//  Copyright © 2017 Quaggie. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let skView = view as? SKView {
            let scene = GameScene(size: CGSize(width: 768, height: 1024))
            scene.scaleMode = .aspectFill
            
            skView.ignoresSiblingOrder = true
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.presentScene(scene)
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
