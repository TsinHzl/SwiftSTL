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
    
    /// 清空队列
    public mutating func removeAll() {
        list.removeAll()
    }
    
    /// 从队头入队
    /// - Parameter element: 要入队的元素
    public mutating func offerFront(_ element: E) {
        list.append(element, at: 0)
    }
    
    /// 从队头出队
    /// - Returns: 出队后的元素，如果队列就返回nil
    public mutating func pollFront() -> E? {
        list.remove(at: 0)
    }
    
    /// 查看队头元素
    /// - Returns: 如果队列为空则返回nil
    public func front() -> E? {
        list.get(at: 0)
    }
    
    /// 从队尾入队
    /// - Parameter element: 要入队的元素
    public mutating func offerRear(_ element: E) {
        list.append(element)
    }
    
    /// 从队尾出队
    /// - Returns: 如果队列为空则返回nil
    public mutating func pollRear() -> E? {
        list.remove(at: list.count - 1)
    }
    
    /// 查看队尾元素
    /// - Returns: 如果队列为空则返回nil
    public func rear() -> E? {
        list.get(at: list.count - 1)
    }
    
    public func debugPrint() {
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
    }
    
    internal func get(at index: Int) -> E? {
        return list.get(at: index)
    }
}


// MARK: - for iterator
extension Dequeue: Sequence {
    public func makeIterator() -> DequeueIterator<E> {
        return DequeueIterator(queue: self)
    }
}

public struct DequeueIterator<Element: Equatable>: IteratorProtocol {
    private var currentIndex = 0
    private var queue: Dequeue<Element>
    
    init(queue: Dequeue<Element>) {
        self.queue = queue
    }
    
    public mutating func next() -> Element? {
        guard currentIndex < queue.count else { return nil }
        
        let element = queue.get(at: currentIndex)
        currentIndex += 1
        return element
    }
}
