//
//  Dequeue.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/12.
//  双端队列

import Foundation


public struct Dequeue<E: Equatable> {
    
    private var list = DoubleLinkedList<E>()
    
    public var count: Int { list.count }
    
    public var isEmpty: Bool { list.isEmpty }
    
    
    public init() { }
    
    public mutating func removeAll() {
        list.removeAll()
    }
    
    public mutating func offerFront(_ element: E) {
        list.append(element, at: 0)
    }
    
    public mutating func pollFront() -> E? {
        list.remove(at: 0)
    }
    
    public func front() -> E? {
        list.get(at: 0)
    }
    
    public mutating func offerRear(_ element: E) {
        list.append(element)
    }
    
    public mutating func pollRear() -> E? {
        list.remove(at: list.count - 1)
    }
    
    public func rear() -> E? {
        list.get(at: list.count - 1)
    }
    
    public func debugPrint() {
        #if DEBUG
        let count = list.count
        var str = ""
        for i in 0 ..< count {
            guard let e = list.get(at: i) else { continue }
            
            if i == count - 1 {
                str += "\(e)"
            } else {
                str += "\(e), "
            }
        }
        
        _debugPrint(str)
        #endif
    }
    
    internal func get(at index: Int) -> E? {
        return list.get(at: index)
    }
}


extension Dequeue: Sequence {
    public func makeIterator() -> some IteratorProtocol {
        return DequeueIterator(queue: self)
    }
}

struct DequeueIterator<Element: Equatable>: IteratorProtocol {
    private var currentIndex = 0
    private var queue: Dequeue<Element>
    
    init(queue: Dequeue<Element>) {
        self.queue = queue
    }
    
    mutating func next() -> Element? {
        guard currentIndex < queue.count else { return nil }
        
        let element = queue.get(at: currentIndex)
        currentIndex += 1
        return element
    }
}
