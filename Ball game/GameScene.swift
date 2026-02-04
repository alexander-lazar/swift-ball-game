//
//  GameScene.swift
//  Ball game
//
//  Created by Alexander Lazar on 13.12.25.
//
// events: mouseDown mouseDragged mouseUp keyDown
import SpriteKit
import AppKit

struct PhysicsCategory {
    static let none: UInt32 = 0
    static let ball: UInt32 = 0x1 << 0
    static let square: UInt32 = 0x1 << 1
}
class GameScene: SKScene {
    
    var ball: SKShapeNode!
    var indicator: SKShapeNode!
    
    var moveLeft: Bool = false
    var moveRight: Bool = false
    var moveUp: Bool = false
    var moveDown: Bool = false
    var arrowLeft: Bool = false
    var arrowRight: Bool = false
    var arrowUp: Bool = false
    var arrowDown: Bool = false
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = .green
        self.view?.window?.makeFirstResponder(self)
        
        let radius: CGFloat = 20
        
        ball = SKShapeNode(circleOfRadius: radius)
        ball.fillColor = .red
        ball.strokeColor = .clear
        ball.position = CGPoint(x: 0, y: 0)
        ball.zPosition = 100
        ball.physicsBody = SKPhysicsBody (circleOfRadius: radius)
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 0
        ball.physicsBody?.usesPreciseCollisionDetection = true
        addChild(ball)
        
        let indicatorRadius: CGFloat = 10
    
        indicator = SKShapeNode(circleOfRadius: indicatorRadius)
        indicator.fillColor = NSColor(
            red: 0.0,
            green: 0.4,
            blue: 0.0,
            alpha: 1.0
        )
        indicator.strokeColor = .clear
        //indicator.position = CGPoint(x: 0, y: 0)
        indicator.isHidden = true
        addChild(indicator)
        //let halfWidth = size.width / 2
        //let halfHeight = size.height / 2
        
        let squareSize: CGFloat = 25
        let greenSquare = SKShapeNode(
            rectOf: CGSize(width: squareSize, height: squareSize)
        )
        greenSquare.fillColor = indicator.fillColor
        greenSquare.strokeColor = .clear
        greenSquare.physicsBody = SKPhysicsBody(
            rectangleOf: CGSize(width: squareSize, height: squareSize)
        )
        greenSquare.physicsBody?.affectedByGravity = false
        greenSquare.physicsBody?.allowsRotation = false
        greenSquare.physicsBody?.isDynamic = false
        greenSquare.physicsBody?.categoryBitMask = PhysicsCategory.square
        greenSquare.physicsBody?.collisionBitMask = PhysicsCategory.ball
        greenSquare.physicsBody?.contactTestBitMask = PhysicsCategory.ball
        
        let halfWidth = size.width / 2
        let halfHeight = size.height / 2
        
        let x = -halfWidth / 16 * 3
        let y = halfHeight / 5 * 2
            
        greenSquare.position = CGPoint(x: x, y: y)
        addChild(greenSquare)
        
        let spawnSquareSize: CGFloat = 10
        
        let spawnSquare = SKShapeNode(
            rectOf: CGSize(width: spawnSquareSize, height: spawnSquareSize)
        )
        
        spawnSquare.fillColor = NSColor(
            red: 0.4,
            green: 0.25,
            blue: 0.1,
            alpha: 1.0
        )
        spawnSquare.strokeColor = .clear
        spawnSquare.position = CGPoint(x: 0, y: 0)
        
        addChild(spawnSquare)
        
        let stump1 = StumpNode()
        stump1.position = CGPoint(x: 0, y: 0)
        stump1.setColor(color: .fromHexCode("747441"), for: .rings)
        stump1.setColor(color: .fromHexCode("B7B77A"), for: .cut)
        stump1.setColor(color: .fromHexCode("BFBF81"), for: .cracks)
        stump1.setColor(color: .fromHexCode("6F6F42"), for: .trunk)
        stump1.setColor(color: .fromHexCode("4E4E25"), for: .roots)
        addChild(stump1)
        
        let stump2 = StumpNode()
        stump2.position = CGPoint(x: 250, y: -50)
        addChild(stump2)
        
        let stump3 = StumpNode()
        stump3.position = CGPoint(x: -500, y: -175)
        addChild(stump3)
        
        let stump4 = StumpNode()
        stump4.position = CGPoint(x: 550, y: -250)
        addChild(stump4)
        
        let stump5 = StumpNode()
        stump5.position = CGPoint(x: -432, y: 375)
        addChild(stump5)
        
        let stump6 = StumpNode()
        stump6.position = CGPoint(x: -32, y: 440)
        addChild(stump6)
        
        let stump7 = StumpNode()
        stump7.position = CGPoint(x: 625, y: -500)
        addChild(stump7)
        
        let stump8 = StumpNode()
        stump8.position = CGPoint(x: -675, y: -550)
        addChild(stump8)
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
        switch event.keyCode {
        case 123:
            arrowLeft = true
        case 124:
            arrowRight = true
        case 126:
            arrowUp = true
        case 125:
            arrowDown = true
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
        switch event.keyCode {
        case 123:
            arrowLeft = false
        case 124:
            arrowRight = false
        case 126:
            arrowUp = false
        case 125:
            arrowDown = false
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
        
        let wasdActive = moveLeft || moveRight || moveUp || moveDown == true
        if wasdActive {
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
        } else {
            if arrowLeft {
                dx-=1
            }
            if arrowRight {
                dx+=1
            }
            if arrowUp {
                dy+=1
            }
            if arrowDown {
                dy-=1
            }
        }
        let length = sqrt(dx * dx + dy * dy)
        
        if length > 0 {
            dx /= length
            dy /= length
        }
        
        let maxSpeed: CGFloat = 300
        let targetVelocity = CGVector(
            dx: dx * maxSpeed,
            dy: dy * maxSpeed
        )

        guard let body = ball.physicsBody else { return }
        let currentVelocity = body.velocity

        let correction = CGVector(
            dx: targetVelocity.dx - currentVelocity.dx,
            dy: targetVelocity.dy - currentVelocity.dy
        )

        // huge acceleration to get an arcade feeling
        let forceScale: CGFloat = body.mass * 60
        
        if dx == 0 && dy == 0 {
            // full stop when no key is currently pressed
            body.velocity = .zero
        } else {
            body.applyForce(
                CGVector(
                    dx: correction.dx * forceScale,
                    dy: correction.dy * forceScale
                )
            )
        }

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
