//
//  Stack.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/11.
//  栈

import Foundation


public struct Stack<E> {
    private var list = [E]()
    
    
    public var count: Int { list.count }
    
    public var isEmpty: Bool { list.isEmpty }
    
    
    public init() { }
    
    public mutating func push(_ element: E?) {
        guard let element = element else { return }
        
        list.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> E? {
        if list.count == 0 { return nil }
        
        return list.remove(at: list.count - 1)
    }
    
    public mutating func top() -> E? {
        return list.last
    }
    
    public mutating func removeAll() {
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
    
    internal func get(at index: Int) -> E? {
        return list[index]
    }
}


extension Stack: Sequence {
    public func makeIterator() -> some IteratorProtocol {
        return StackIterator(stack: self)
    }
}

struct StackIterator<Element>: IteratorProtocol {
    private var currentIndex = 0
    private var stack: Stack<Element>
    
    init(stack: Stack<Element>) {
        self.stack = stack
    }
    
    mutating func next() -> Element? {
        guard currentIndex < stack.count else { return nil }
        
        let element = stack.get(at: currentIndex)
        currentIndex += 1
        return element
    }
}
