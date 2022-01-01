//
//  Snake.swift
//  Snake
//
//  Created by Андрей Мишин on 30.12.2021.
//

import UIKit
import SpriteKit

struct CollisionCategories {
    
    static let Snake: UInt32 = 0x1 << 0 //0001 2
    static let SnakeHead: UInt32 = 0x1 << 1 //0010 4
    static let Apple: UInt32 = 0x1 << 2 // 0100 8
    static let EdgeBody: UInt32 = 0x1 << 3 // 1000 16
    
}

class Snake: SKShapeNode {
    
    var body = [SnakeBodyPart]()
    let moveSpeed: CGFloat = 125.0
    var angle: CGFloat = 0.0
    
    init(atPoint point: CGPoint) {
        super.init()
        
        let head = SnakeHead(atPoint: point)
        body.append(head)
        addChild(head)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addBody() {
        let newBodyPart = SnakeBodyPart(atPoint: CGPoint(x: body[0].position.x, y: body[0].position.y))
        body.append(newBodyPart)
        addChild(newBodyPart)
    }
    
    func move() {
        guard !body.isEmpty else {return}
        
        let head = body[0]
        moveHead(head)
        
        for index in (0..<body.count) where index > 0 {
            let previosBodyPart = body[index - 1]
            let currentBodyPart = body[index]
            
            moveBodyPart(previosBodyPart, c: currentBodyPart)
        }
        
    }
    
    func moveHead(_ head: SnakeBodyPart) {
        let dx = moveSpeed * sin(angle)
        let dy = moveSpeed * cos(angle)
        
        let nextPosition = CGPoint(x: head.position.x + dx, y: head.position.y + dy)
        
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0)
        head.run(moveAction)
        
    }
    
    func moveBodyPart(_ p: SnakeBodyPart, c: SnakeBodyPart) {
        let moveAction = SKAction.move(to: CGPoint(x: p.position.x, y: p.position.y), duration: 0.1)
        c.run(moveAction)
    }
    
    func moveClockWise() {
        angle += CGFloat(Double.pi / 2)
    }
    
    func moveCounterClockwise() {
        angle -= CGFloat(Double.pi / 2)
    }
}
