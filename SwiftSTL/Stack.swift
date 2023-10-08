//
//  Stack.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/11.
//  栈  FILO - First In Last Out

import Foundation


public struct Stack<E> {
    private var list = [E]()
    
    
    /// 当前栈个数
    public var count: Int { list.count }
    
    /// 当前栈是否为空
    public var isEmpty: Bool { list.isEmpty }
    
    
    public init() { }
    
    /// 入栈
    /// - Parameter element: 要入栈的元素
    public mutating func push(_ element: E) {
        list.append(element)
    }
    
    /// 出栈
    /// - Returns: 如果栈为空则返回nil
    @discardableResult
    public mutating func pop() -> E? {
        if list.count == 0 { return nil }
        
        return list.remove(at: list.count - 1)
    }
    
    /// 查看栈顶元素
    /// - Returns: 如果栈为空则返回nil
    public mutating func top() -> E? {
        return list.last
    }
    
    /// 清空栈
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


// MARK: - for iterator
extension Stack: Sequence {
    public func makeIterator() -> StackIterator<E> {
        return StackIterator(stack: self)
    }
}

public struct StackIterator<Element>: IteratorProtocol {
    private var currentIndex = 0
    private var stack: Stack<Element>
    
    init(stack: Stack<Element>) {
        self.stack = stack
    }
    
    public mutating func next() -> Element? {
        guard currentIndex < stack.count else { return nil }
        
        let element = stack.get(at: currentIndex)
        currentIndex += 1
        return element
    }
}
