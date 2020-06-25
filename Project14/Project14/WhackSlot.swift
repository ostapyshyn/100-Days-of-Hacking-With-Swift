//
//  WhackSlot.swift
//  Project14
//
//  Created by Volodymyr Ostapyshyn on 23.06.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {
    
    var isVisible = false
    var isHit = false
    
    var charNode: SKSpriteNode!
    
    func configure(at position: CGPoint) {
        self.position = position

        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")

        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        

        addChild(cropNode)
    }
    
    private func addEmitter(called name: String, at position: CGPoint, with zPosition: CGFloat = 0) {

        if let emitter = SKEmitterNode(fileNamed: name) {
            emitter.position = position
            emitter.zPosition = zPosition

            let numParticles = Double(emitter.numParticlesToEmit)
            let lifetime = Double(emitter.particleLifetime)
            let emitterDuration = numParticles * lifetime

            let addEmitterAction = SKAction.run { self.addChild(emitter) }
            let waitAction = SKAction.wait(forDuration: emitterDuration)
            let removeAction = SKAction.run { emitter.removeFromParent() }
            let actions = [addEmitterAction, waitAction, removeAction]
            let sequence = SKAction.sequence(actions)
            run(sequence)
        }

    }
    
    func show(hideTime: Double) {
        addEmitter(called: "mud", at: CGPoint(x: 10, y: -30))
        if isVisible { return }
        charNode.xScale = 1
        charNode.yScale = 1
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false

        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
            self?.hide()
        }
    }
    
    func hide() {
        if !isVisible { return }

        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
    }
    
    func hit() {
        addEmitter(called: "smoke", at: charNode.position, with: 2)
        isHit = true

        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        let notVisible = SKAction.run { [unowned self] in self.isVisible = false }
        
        charNode.run(SKAction.sequence([delay, hide, notVisible]))
    }
    
    

}
