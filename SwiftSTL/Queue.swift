//
//  Queue.swift
//  SwiftSTL
//
//  Created by MacBook on 2023/9/12.
//  单向队列

import Foundation


public struct Queue<Element: Equatable> {
    private var list = DoubleLinkedList<Element>()
    
    public var count: Int { list.count }
    
    public var isEmpty: Bool { list.isEmpty }
    
    
    public init() { }
    
    public mutating func removeAll() {
        list.removeAll()
    }
    
    public mutating func offer(_ element: Element) {
        list.append(element)
    }
    
    public mutating func poll() -> Element? {
        list.remove(at: 0)
    }
    
    public func front() -> Element? {
        list.get(at: 0)
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
