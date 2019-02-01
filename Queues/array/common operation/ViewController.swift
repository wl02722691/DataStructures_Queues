//
//  ViewController.swift
//  common operation
//
//  Created by 張書涵 on 2019/1/28.
//  Copyright © 2019 張書涵. All rights reserved.
//

import UIKit

public protocol Queue {
    // associatedtype = generic 的型別代號, confirm 的時候再決定就好
    associatedtype Element
    mutating func enqueue(_ element: Element) ->Bool
    mutating func dequeue()->Element?
    var isEmpty: Bool { get}
    var peek:Element? { get }
    
}

public struct QueueArray<T>: Queue {
    
    //書上是寫[T]
    private var array:[String] = []
    
    public init(){}
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    //bigO(1)
    
    public var peek: String? {
        print(array.first)
        return array.first
    }
    //bigO(1)
    
    public mutating func enqueue(_ element: String) -> Bool {
        array.append(element)
        return true
        //bigO(1)
    }
    
    public mutating func dequeue() -> String? {
        return isEmpty ? nil : array.removeFirst()
        //isEmpty = true 回傳nil false就removeFirst()
    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var queue = QueueArray<String>()
        queue.enqueue("Alice")
        queue.enqueue("Cindy")
        queue.enqueue("Ethan")
        queue.enqueue("Justin")
        queue.peek
        print(queue)
        
    }

}

extension QueueArray: CustomStringConvertible {
    public var description: String {

        return array.description
        
    }
}
