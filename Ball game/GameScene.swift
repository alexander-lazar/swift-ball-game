//
//  GameScene.swift
//  Ball game
//
//  Created by Alexander Lazar on 13.12.25.
//
// events: mouseDown mouseDragged mouseUp keyDown
import SpriteKit
import AppKit

class GameScene: SKScene {
    
    var ball: SKShapeNode!
    var indicator: SKShapeNode!
    
    var moveLeft: Bool = false
    var moveRight: Bool = false
    var moveUp: Bool = false
    var moveDown: Bool = false
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.view?.window?.makeFirstResponder(self)
        
        let radius: CGFloat = 20
        
        ball = SKShapeNode(circleOfRadius: radius)
        ball.fillColor = .red
        ball.strokeColor = .clear
        ball.position = CGPoint(x: 0, y: 0)
        
        addChild(ball)
        
        let indicatorRadius: CGFloat = 10
    
        indicator = SKShapeNode(circleOfRadius: indicatorRadius)
        indicator.fillColor = .green
        indicator.strokeColor = .clear
        indicator.position = CGPoint(x: 0, y: 0)
        indicator.isHidden = true
        addChild(indicator)
        //let halfWidth = size.width / 2
        //let halfHeight = size.height / 2
    }
        
    override func keyDown(with event: NSEvent) {
        switch event.charactersIgnoringModifiers?.lowercased() {
        case "a":
            moveLeft = true
        case "d":
            moveRight = true
        case "w":
            moveUp = true
        case "s":
            moveDown = true
        default:
            break
        }
    }
    override func keyUp(with event: NSEvent) {
        switch event.charactersIgnoringModifiers?.lowercased() {
        case "a":
            moveLeft = false
        case "d":
            moveRight = false
        case "w":
            moveUp = false
        case "s":
            moveDown = false
        default:
            break
        }
    }
    override func update(_ currentTime: TimeInterval) {
        let indiecatorRadius: CGFloat = 10
        let halfWidth = size.width / 2 - indiecatorRadius
        let halfHeight = size.height / 2 - indiecatorRadius
        
        var dx : CGFloat = 0
        var dy : CGFloat = 0
        if moveLeft {
            dx-=1
        }
        if moveRight {
            dx+=1
        }
        if moveUp {
            dy+=1
        }
        if moveDown {
            dy-=1
        }
        let length = sqrt(dx * dx + dy * dy)
        
        if length > 0 {
            dx /= length
            dy /= length
        }
        let speed : CGFloat = 5
        ball.position.x += dx * speed
        ball.position.y += dy * speed
        
        let isOutside =
        ball.position.x < -halfWidth ||
        ball.position.x > halfWidth ||
        ball.position.y < -halfHeight ||
        ball.position.y > halfHeight
        if isOutside {
            indicator.isHidden = false
            var x = ball.position.x
            var y = ball.position.y
            
            if ball.position.x < -halfWidth {
                x = -halfWidth
            } else if ball.position.x > halfWidth {
             x = halfWidth
            }
            
            if ball.position.y < -halfHeight {
                y = -halfHeight
            } else if ball.position.y > halfHeight {
             y = halfHeight
            }
            
            //x = min(max(x, -halfWidth), halfWidth)
            //y = min(max(y, -halfHeight), halfHeight)
            indicator.position = CGPoint(x: x, y: y)
        } else {
            indicator.isHidden = true
        }
    }
}
