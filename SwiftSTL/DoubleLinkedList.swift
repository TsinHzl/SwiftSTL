//
//  DoubleLinkedList.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/9.
//  双向链表

import Foundation


public struct DoubleLinkedList<Element: Equatable>: List {
    
    class Node<Element: Equatable> {
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
    
    
    private(set) var count: Int = 0
    private var first: Node<Element>?
    private var last: Node<Element>?
    
    
    public func get(at index: Int) -> Element? {
        return getNode(index)?.element
    }

    public func set(_ element: Element?, at index: Int) -> Element? {
        guard let element = element else { return nil }
        
        let node = getNode(index)
        let old = node?.element
        node?.element = element
        
        return old
    }
    
    public mutating func append(_ element: Element?, at index: Int) {
        guard let element = element else { return }
        
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
            let next = node?.next
            let newNode = Node(element: element, prev: node, next: next)
            node?.prev = newNode
            if prev == nil {
                first = newNode
            } else {
                prev?.next = newNode
            }
        }
        
        count += 1
    }
    
    public mutating func remove(at index: Int) -> Element? {
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
    
    public func indexOf(_ element: Element?) -> Int? {
        guard let element = element else { return nil }
        
        var node = first
        for i in 0 ..< count {
            if node?.element == element { return i }
            
            node = node?.next
        }
        return nil
    }
    
    public mutating func clear() {
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
    private func getNode(_ index: Int?) -> Node<Element>? {
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
