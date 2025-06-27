//
//  DoubleLinkedList.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/9.
//  双向链表

import Foundation


public struct DoubleLinkedList<E: Equatable>: List {
    
    class Node<E: Equatable> {
        var element: E
        var prev: Node<E>?
        var next: Node<E>?
        
        
        deinit {
            _debugPrint("--- DoubleLinkedList.Node.deinit ---")
        }
        
        init(element: E, prev: Node<E>?, next: Node<E>?) {
            self.element = element
            self.prev = prev
            self.next = next
        }
    }
    
    
    public private(set) var count: Int = 0
    private var first: Node<E>?
    private var last: Node<E>?
    
    
    public init() { }
    
    /// 获取指定index位置的元素
    /// - Parameter index: 索引
    /// - Returns: 没有的话就返回空
    public func get(at index: Int) -> E? {
        return getNode(index)?.element
    }
    
    /// 设置指定index位置的元素
    /// - Parameters:
    ///   - element: 要设置的元素
    ///   - index: 所以呢
    /// - Returns: 返回被替换的元素，为nil的话，就证明没被替换掉
    public func set(_ element: E, at index: Int) -> E? {
        
        let node = getNode(index)
        let old = node?.element
        node?.element = element
        
        return old
    }
    
    /// 在指定index位置添加元素
    /// - Parameters:
    ///   - element: 要添加的元素
    ///   - index: 索引
    public mutating func append(_ element: E, at index: Int) {
        
        do {
            try rangeCheckForAdd(at: index)
        } catch {}
        
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
    
    /// 移除指定index位置的元素
    /// - Parameter index: 索引
    /// - Returns: 返回被移除的元素，如果没有就返回nil
    @discardableResult
    public mutating func remove(at index: Int) -> E? {
        do {
            try rangeCheck(at: index)
        } catch { return nil }
        
        let node = getNode(index)
        let prev = node?.prev
        let next = node?.next
        let old = node?.element
        if prev == nil {
            first = next;
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
    
    /// 获取元素的索引
    /// - Parameter element: 要获取索引的元素
    /// - Returns: 返回元素的索引，元素不存在的话，就返回nil
    public func indexOf(_ element: E?) -> Int? {
        guard let element = element else { return nil }
        
        var node = first
        for i in 0 ..< count {
            if node?.element == element { return i }
            
            node = node?.next
        }
        return nil
    }
    
    /// 清空链表
    public mutating func removeAll() {
        count = 0
        first = nil
        last = nil
    }
    
    public func debugPrint() {
        var node = first
        var str = ""
        while node != nil {
            if node?.next == nil {
                str += "\(node!.element)"
            } else {
                str += "\(node!.element) -> "
            }
            node = node?.next
        }
        _debugPrint(str)
    }
}

extension DoubleLinkedList {
    private func getNode(_ index: Int?) -> Node<E>? {
        guard let index = index else { return nil }
        
        do {
            try rangeCheck(at: index)
        } catch {
            return nil
        }
        
        if index < (count >> 1) {
            var node = first
            for _ in 0 ..< index {
                node = node?.next
            }
            return node
        } else {
            var node = last
            for _ in index ..< count - 1 {
                node = node?.prev
            }
            return node
        }
    }
}


// MARK: - for iterator
extension DoubleLinkedList: Sequence {
    public func makeIterator() -> DoubleLinkedListIterator<E> {
        return DoubleLinkedListIterator(linkedList: self)
    }
}

public struct DoubleLinkedListIterator<Element: Equatable>: IteratorProtocol {
    private var currentIndex = 0
    private var linkedList: DoubleLinkedList<Element>
    
    init(linkedList: DoubleLinkedList<Element>) {
        self.linkedList = linkedList
    }
    
    public mutating func next() -> Element? {
        guard currentIndex < linkedList.count else { return nil }
        
        let element = linkedList.get(at: currentIndex)
        currentIndex += 1
        return element
    }
}

