//
//  Dequeue.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/12.
//  双端队列

import Foundation


public struct Dequeue<Element: Equatable> {
    
    private var list = DoubleLinkedList<Element>()
    
    public var count: Int { list.count }
    
    public var isEmpty: Bool { list.isEmpty }
    
    public mutating func removeAll() {
        list.removeAll()
    }
    
    public mutating func offerFront(_ element: Element) {
        list.append(element, at: 0)
    }
    
    public mutating func pollFront() -> Element? {
        list.remove(at: 0)
    }
    
    public func front() -> Element? {
        list.get(at: 0)
    }
    
    public mutating func offerRear(_ element: Element) {
        list.append(element)
    }
    
    public mutating func pollRear() -> Element? {
        list.remove(at: list.count - 1)
    }
    
    public func rear() -> Element? {
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
}
