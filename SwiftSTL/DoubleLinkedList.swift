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
    
    public func get(at index: Int) -> E? {
        return getNode(index)?.element
    }
    
    public func set(_ element: E, at index: Int) -> E? {
        
        let node = getNode(index)
        let old = node?.element
        node?.element = element
        
        return old
    }
    
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
        #if DEBUG
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
        #endif
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


extension DoubleLinkedList: Sequence {
    public func makeIterator() -> some IteratorProtocol {
        return DoubleLinkedListIterator(linkedList: self)
    }
}

struct DoubleLinkedListIterator<Element: Equatable>: IteratorProtocol {
    private var currentIndex = 0
    private var linkedList: DoubleLinkedList<Element>
    
    init(linkedList: DoubleLinkedList<Element>) {
        self.linkedList = linkedList
    }
    
    mutating func next() -> Element? {
        guard currentIndex < linkedList.count else { return nil }
        
        let element = linkedList.get(at: currentIndex)
        currentIndex += 1
        return element
    }
}

