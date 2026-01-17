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
        /// Stamm
        case trunk
        /// Risse
        case cracks
        /// Ringe
        case rings
        /// Schnitt
        case cut
        /// Wurzeln
        case roots
    }
    
    private var layers: [Layer: SKSpriteNode] = [:]
    private var defaultColors: [Layer: NSColor] = [:]
    
    init(assets: [Layer: String] = [
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
                    defaultColors[layerType] = color
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
    
    func setColor(color: NSColor? = nil, for layerType: Layer) {
        if let layer = layers[layerType], let color = color ?? defaultColors[layerType] {
            layer.color = color
        }
    }
}
