//
//  StumpNode.swift
//  Ball game
//
//  Created by Alexander Lazar on 05.01.26.
//

import SpriteKit
import AppKit

class StumpNode: SKNode {
    
    enum Layer: String, CaseIterable {
        case trunk
        case cracks
        case rings
        case cut
        case roots
    }
    
    private var layers: [Layer: SKSpriteNode] = [:]
    
    
    init(assets: [Layer: String] = [
        // Image names from the asset catalog
        .trunk: "trunk",
        .cracks: "cracks",
        .rings: "rings",
        .cut: "cut",
        .roots: "roots"
    ]) {
        super.init()
        
        let drawOrder: [Layer] = [ .roots, .trunk, .cut, .rings, .cracks ]
        
        
        for (index, layerType) in drawOrder.enumerated() {
            let imageName = assets[layerType] ?? layerType.rawValue
            if let nsImage = NSImage(named: imageName) {
                let texture = SKTexture(image: nsImage)
                let sprite = SKSpriteNode(texture: texture)
                
                sprite.zPosition = CGFloat(index)
                
                if let color = NSColor(named: "stump_\(imageName)") {
                    sprite.color = color
                    sprite.colorBlendFactor = 1.0
    
                }
                
                addChild(sprite)
                layers[layerType] = sprite
                
            } else {
                print("Could not find image: \(imageName)")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not Implemented")
    }
}
