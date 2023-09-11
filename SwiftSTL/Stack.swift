//
//  Stack.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/11.
//

import Cocoa

class Stack<Element> {
    private lazy var list = [Element]()
    
    var size: Int { list.count }
    var isEmpty: Bool { list.isEmpty }
    
    public func push(_ element: Element?) {
        guard let element = element else { return }
        
        list.append(element)
    }
    
    public func pop() -> Element? {
        return list.remove(at: list.count - 1)
    }
    
    public func top() -> Element? {
        return list.last
    }
    
    public func clear() {
        list.removeAll()
    }
}
