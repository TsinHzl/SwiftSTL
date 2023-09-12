//
//  Stack.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/11.
//  栈

import Foundation


public struct Stack<Element> {
    private var list = [Element]()
    
    
    public var count: Int { list.count }
    
    public var isEmpty: Bool { list.isEmpty }
    
    public mutating func push(_ element: Element?) {
        guard let element = element else { return }
        
        list.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        if list.count == 0 { return nil }
        
        return list.remove(at: list.count - 1)
    }
    
    public mutating func top() -> Element? {
        return list.last
    }
    
    public mutating func clear() {
        list.removeAll()
    }
    
    public func debugPrint() {
        #if DEBUG
        let count = list.count
        var str = ""
        for i in 0 ..< count {
            let e = list.reversed()[i]
            if i == count - 1 {
                str += "\(e)  bottom"
            } else if i == 0 {
                str += "top  \(e), "
            } else {
                str += "\(e), "
            }
        }
        
        _debugPrint(str)
        #endif
    }
}
