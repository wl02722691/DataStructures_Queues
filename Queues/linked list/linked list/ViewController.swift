//
//  ViewController.swift
//  linked list
//
//  Created by 張書涵 on 2019/1/29.
//  Copyright © 2019 張書涵. All rights reserved.
//

import UIKit

public protocol Queue {
    
    associatedtype Element
    mutating func enqueue(_ element: Element) ->Bool
    mutating func dequeue()->Element?
    var isEmpty: Bool { get }
    var peek:Element? { get }
    
}

public class Node<Value> {
    public var value: Value
    public var next: Node?
    
    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

public struct DoublyLinkList<Value> {
    
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty:Bool {
        return head == nil
    }
    
    public var first: Node<Value>? {
        return head
    }
    
    public var last: Node<Value>? {
        return tail
    }
    
    public mutating func push(_ value:Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value:Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    public mutating func remove(after node:Node<Value>) -> Value{
        defer {
            if node.next === tail {
                tail = node
            }
            head = node.next
        }
        return node.value
    }
}


public class QueueLinkedList<T>: Queue {
    
    private var list = DoublyLinkList<String>()
    public init() {}
    
    public func enqueue(_ element: String) -> Bool {
        list.append(element)
        return true
    }
    
    public func dequeue() -> String? {
        guard !list.isEmpty,let element = list.first else {
            return nil
        }
        return list.remove(after: element)
    }
    
    public var isEmpty: Bool {
        return list.isEmpty
    }
    
    public var peek: String? {
        return list.first?.value
    }
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var queue = QueueLinkedList<String>()
        queue.enqueue("Gary")
        queue.enqueue("Nia")
        queue.enqueue("Luke")
        
        queue.dequeue()
        
        queue.enqueue("Alice")
        
    }
}
