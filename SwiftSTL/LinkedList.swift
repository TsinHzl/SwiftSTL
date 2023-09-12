//
//  LinkedList.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/9.
//  单向链表

import Foundation

public struct LinkedList<Element: Equatable>: List {
    class Node<Element: Equatable> {
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
    
    private var first: Node<Element>?
    
    
    public private(set) var count: Int = 0
    
    public private(set) var isEmpty: Bool = false
    
    
    public init() { }
    
    public func get(at index: Int) -> Element? {
        return getNode(at: index)?.element
    }
    
    public func set(_ element: Element, at index: Int) -> Element? {
        
        let node = getNode(at: index)
        let oldElement = node?.element
        
        node?.element = element
        
        return oldElement
    }
    
    public mutating func append(_ element: Element, at index: Int) {
        
        do {
            try rangeCheckForAdd(at: index)
            if index == 0 {
                first = Node(element: element, next: first)
            } else {
                let prevNode = getNode(at: index - 1)
                let newNode = Node(element: element, next: prevNode?.next)
                prevNode?.next = newNode
            }
            count += 1
        } catch { }
    }
    
    @discardableResult
    public mutating func remove(at index: Int) -> Element? {
        do {
            try rangeCheck(at: index)
            
            var oldElement: Element?
            if index == 0 {
                oldElement = first?.element
                first = first?.next
            } else {
                let prevNode = getNode(at: index - 1)
                oldElement = prevNode?.next?.element
                prevNode?.next = prevNode?.next?.next
            }
            return oldElement
        } catch {
            return nil
        }
    }
    
    public mutating func remove(_ element: Element?) {
        if let index = indexOf(element) {
            let _ = remove(at: index)
        }
    }
    
    public func indexOf(_ element: Element?) -> Int? {
        guard let element = element else { return nil }
        
        var node = first
        var index = -1
        var isHit = false
        while node != nil {
            index += 1
            if node?.element == element {
                isHit = true
                break
            }
            node = node?.next
        }
        
        return isHit ? index : nil
    }
    
    public mutating func removeAll() {
        count = 0
        first = nil
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

extension LinkedList {
    private func getNode(at index: Int) -> Node<Element>? {
        do {
            try rangeCheck(at: index)
            
            var node = first
            for _ in 0 ..< index {
                node = node?.next
            }
            
            return node
        } catch {
            return nil
        }
    }
}
