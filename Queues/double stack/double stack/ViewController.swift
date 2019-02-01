//
//  ViewController.swift
//  double stack
//
//  Created by 張書涵 on 2019/1/30.
//  Copyright © 2019 張書涵. All rights reserved.
//

import UIKit

public protocol Queue {
    
    associatedtype Element
    mutating func enqueue(_ element: Element) ->Bool
    mutating func dequeue()->Element?
    var isEmpty: Bool { get}
    var peek:Element? { get }
    
}

public struct QueueStack<T>: Queue {
    public mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        return leftStack.popLast()
    }
    
    public var isEmpty: Bool {
        return leftStack.isEmpty && rightStack.isEmpty
    }
    
    public var peek: T?
    
    
    public typealias Element = T
    
    private var leftStack: [T] = []
    private var rightStack: [T] = []
    public init() {}
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var queue = QueueStack<String>()
        queue.enqueue("Alice1")
        print(queue)
        queue.enqueue("Alice2")
        print(queue)
        queue.enqueue("Alice3")
        print(queue)
        queue.dequeue()
        print(">>>>>>>>dequeue",queue)
        queue.dequeue()
        print(">>>>>>>>dequeue",queue)
        queue.enqueue("Alice4")
        print(queue)
        queue.dequeue()
        print(">>>>>>>>dequeue",queue)
    }


}

