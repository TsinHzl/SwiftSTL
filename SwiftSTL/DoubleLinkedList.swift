//
//  DoubleLinkedList.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/9.
//  双向链表

import Foundation


public struct DoubleLinkedList<E: Equatable>: List {
    
    private class Node<Element: Equatable> {
        var element: Element
        var prev: Node<Element>?
        var next: Node<Element>?
        
        deinit {
            _debugPrint("--- DoubleLinkedList.Node.deinit ---")
        }
        
        init(element: Element, prev: Node<Element>?, next: Node<Element>?) {
            self.element = element
            self.prev = prev
            self.next = next
        }
    }
    
    
    public private(set) var count: Int = 0
    private var first: Node<E>?
    private var last: Node<E>?
    
    
    public init() { }
    
    public func get(at index: Int) -> E? {
        return getNode(index)?.element
    }
    
    /// 设置指定index位置的元素，返回被替换的旧元素
    public func set(_ element: E, at index: Int) -> E? {
        let node = getNode(index)
        let old = node?.element
        node?.element = element
        return old
    }
    
    public mutating func append(_ element: E, at index: Int) {
        guard rangeCheckForAdd(at: index) else { return }
        
        if index == count {
            let l = last
            let newNode = Node(element: element, prev: l, next: nil)
            last = newNode
            if l == nil {
                first = newNode
            } else {
                l?.next = newNode
            }
        } else {
            let node = getNode(index)
            let prev = node?.prev
            let newNode = Node(element: element, prev: prev, next: node)
            node?.prev = newNode
            if prev == nil {
                first = newNode
            } else {
                prev?.next = newNode
            }
        }
        
        count += 1
    }
    
    @discardableResult
    public mutating func remove(at index: Int) -> E? {
        guard rangeCheck(at: index) else { return nil }
        
        let node = getNode(index)
        let prev = node?.prev
        let next = node?.next
        let old = node?.element
        
        if prev == nil {
            first = next
        } else {
            prev?.next = next
        }
        
        if next == nil {
            last = prev
        } else {
            next?.prev = prev
        }
        
        count -= 1
        return old
    }
    
    public func indexOf(_ element: E?) -> Int? {
        guard let element = element else { return nil }
        
        var node = first
        for i in 0 ..< count {
            if node?.element == element { return i }
            node = node?.next
        }
        return nil
    }
    
    public mutating func removeAll() {
        count = 0
        first = nil
        last = nil
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
    
    private func getNode(_ index: Int?) -> Node<E>? {
        guard let index = index, rangeCheck(at: index) else { return nil }
        
        if index < (count >> 1) {
            var node = first
            for _ in 0 ..< index { node = node?.next }
            return node
        } else {
            var node = last
            for _ in index ..< count - 1 { node = node?.prev }
            return node
        }
    }
}


// MARK: - Sequence
extension DoubleLinkedList: Sequence {
    public func makeIterator() -> Iterator {
        return Iterator(currentNode: first)
    }
    
    /// 嵌套迭代器类型，可访问 private Node，O(n) 遍历
    public struct Iterator: IteratorProtocol {
        private var currentNode: DoubleLinkedList.Node<E>?
        
        private init(currentNode: DoubleLinkedList.Node<E>?) {
            self.currentNode = currentNode
        }
        
        public mutating func next() -> E? {
            guard let node = currentNode else { return nil }
            currentNode = node.next
            return node.element
        }
    }
}
