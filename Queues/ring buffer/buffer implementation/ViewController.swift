//
//  ViewController.swift
//  buffer implementation
//
//  Created by 張書涵 on 2019/1/29.
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

public struct RingBuffer<T> {
    fileprivate var array: [T?]
    fileprivate var readIndex = 0
    fileprivate var writeIndex = 0
    
    public init(count: Int) {
        array = [T?](repeating: nil, count: count)
    }
    
    public mutating func write(_ element: T) -> Bool {
        if !isFull {
            array[writeIndex % array.count] = element
            writeIndex += 1
            return true
        } else {
            return false
        }
    }
    
    public mutating func read() -> T? {
        if !isEmpty {
            let element = array[readIndex % array.count]
            readIndex += 1
            return element
        } else {
            return nil
        }
    }
    
    fileprivate var availableSpaceForReading: Int {
        return writeIndex - readIndex
    }
    
    public var isEmpty: Bool {
        return availableSpaceForReading == 0
    }
    
    fileprivate var availableSpaceForWriting: Int {
        return array.count - availableSpaceForReading
    }
    
    public var isFull: Bool {
        return availableSpaceForWriting == 0
    }
}

public struct QueueRingBuffer<T>:Queue {
 
    
    private var ringBuffer: RingBuffer<T>
    
    public init(count:Int) {
        ringBuffer = RingBuffer<T>(count: count)
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        return ringBuffer.write(element)
    }
    
    public mutating func dequeue() -> T? {
        return isEmpty ? nil : ringBuffer.read()
    }
    
    public var isEmpty: Bool {
        return ringBuffer.isEmpty
    }
    
    public var peek: T? {
        return ringBuffer.array.first as? T
    }
    
    public typealias Element = T
    
    
    
}


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var queue = QueueRingBuffer<String>(count: 2)
        queue.enqueue("Gary")
        queue.enqueue("Gary")
        print(queue)
        queue.dequeue()
        print(">>dequeue()",queue)
        queue.enqueue("Alice")
        print(queue)
    }
}
