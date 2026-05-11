//
//  Queue.swift
//  SwiftSTL
//
//  Created by MacBook on 2023/9/12.
//  单向队列  FIFO - First In First Out

import Foundation


public struct Queue<E: Equatable> {
    private var list = DoubleLinkedList<E>()
    
    public var count: Int { list.count }
    
    public var isEmpty: Bool { list.isEmpty }
    
    
    public init() { }
    
    /// 清空队列
    public mutating func removeAll() {
        list.removeAll()
    }
    
    /// 入队： 从队尾入队
    /// - Parameter element: 要入队的元素
    public mutating func offer(_ element: E) {
        list.append(element)
    }
    
    /// 出队： 从队头出队
    /// - Returns: 如果队列为空则返回nil
    public mutating func poll() -> E? {
        list.remove(at: 0)
    }
    
    /// 查看队头元素
    /// - Returns: 如果队列为空则返回nil
    public func front() -> E? {
        list.get(at: 0)
    }
    
    public func debugPrint() {
        _debugPrint(list.map { "\($0)" }.joined(separator: ", "))
    }
    
    internal func get(at index: Int) -> E? {
        return list.get(at: index)
    }
}


// MARK: - Sequence
extension Queue: Sequence {
    public func makeIterator() -> DoubleLinkedList<E>.Iterator {
        return list.makeIterator()
    }
}
