//
//  LinkedList.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/9.
//  单向链表

import Foundation


public struct LinkedList<E: Equatable>: List {
    
    private class Node<Element: Equatable> {
        var element: Element
        var next: Node?
        
        deinit {
            _debugPrint("--- LinkedList.Node.deinit ---")
        }
        
        init(element: Element, next: Node?) {
            self.element = element
            self.next = next
        }
    }
    
    private var first: Node<E>?
    
    /// 链表的个数
    public private(set) var count: Int = 0
    // isEmpty 由 List 协议扩展提供（count == 0）
    
    
    public init() { }
    
    public func get(at index: Int) -> E? {
        return getNode(at: index)?.element
    }
    
    public func set(_ element: E, at index: Int) -> E? {
        let node = getNode(at: index)
        let oldElement = node?.element
        node?.element = element
        return oldElement
    }
    
    public mutating func append(_ element: E, at index: Int) {
        guard rangeCheckForAdd(at: index) else { return }
        if index == 0 {
            first = Node(element: element, next: first)
        } else {
            let prevNode = getNode(at: index - 1)
            let newNode = Node(element: element, next: prevNode?.next)
            prevNode?.next = newNode
        }
        count += 1
    }
    
    @discardableResult
    public mutating func remove(at index: Int) -> E? {
        guard rangeCheck(at: index) else { return nil }
        
        let oldElement: E?
        if index == 0 {
            oldElement = first?.element
            first = first?.next
        } else {
            let prevNode = getNode(at: index - 1)
            oldElement = prevNode?.next?.element
            prevNode?.next = prevNode?.next?.next
        }
        count -= 1
        return oldElement
    }
    
    public mutating func remove(_ element: E?) {
        if let index = indexOf(element) {
            _ = remove(at: index)
        }
    }
    
    public func indexOf(_ element: E?) -> Int? {
        guard let element = element else { return nil }
        
        var node = first
        var index = 0
        while let current = node {
            if current.element == element { return index }
            node = current.next
            index += 1
        }
        return nil
    }
    
    public mutating func removeAll() {
        count = 0
        first = nil
    }
    
    public func debugPrint() {
        var node = first
        var str = ""
        while let current = node {
            str += current.next == nil ? "\(current.element)" : "\(current.element) -> "
            node = current.next
        }
        _debugPrint(str)
    }
    
    private func getNode(at index: Int) -> Node<E>? {
        guard rangeCheck(at: index) else { return nil }
        var node = first
        for _ in 0 ..< index { node = node?.next }
        return node
    }
}


// MARK: - Sequence
extension LinkedList: Sequence {
    public func makeIterator() -> Iterator {
        return Iterator(currentNode: first)
    }
    
    /// 嵌套迭代器类型，可访问 private Node，O(n) 遍历
    public struct Iterator: IteratorProtocol {
        // 持有节点指针而非索引，避免 O(n²)
        private var currentNode: LinkedList.Node<E>?
        
        init(currentNode: LinkedList.Node<E>?) {
            self.currentNode = currentNode
        }
        
        public mutating func next() -> E? {
            guard let node = currentNode else { return nil }
            currentNode = node.next
            return node.element
        }
    }
}
