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
        guard !list.isEmpty else { return nil }
        return list.remove(at: list.count - 1)
    }
    
    /// 查看栈顶元素
    /// - Returns: 如果栈为空则返回nil
    public func top() -> E? {
        return list.last
    }
    
    /// 清空栈
    public mutating func removeAll() {
        list.removeAll()
    }
    
    public func debugPrint() {
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
    }
    
    internal func get(at index: Int) -> E? {
        guard index >= 0 && index < list.count else { return nil }
        return list[index]
    }
}


// MARK: - Sequence
extension Stack: Sequence {
    public func makeIterator() -> IndexingIterator<[E]> {
        return list.makeIterator()
    }
}
