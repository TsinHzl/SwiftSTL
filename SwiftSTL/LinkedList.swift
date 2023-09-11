//
//  LinkedList.swift
//  SwiftSTL
//
//  Created by MacBook on 2023/9/9.
//

import Cocoa

class LinkedList<Element: Equatable>: List {
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
    
    
    private(set) var size: Int = 0
    
    private(set) var isEmpty: Bool = false
    
    
    deinit {
        _debugPrint("--- LinkedList.deinit ---")
    }
    
    public func contains(_ element: Element?) {
        
    }
    
    public func get(at index: Int) -> Element? {
        return getNode(at: index)?.element
    }
    
    public func set(_ element: Element?, at index: Int) -> Element? {
        guard let element = element else { return nil }
        
        let node = getNode(at: index)
        let oldElement = node?.element
        
        node?.element = element
        
        return oldElement
    }
    
    public func append(_ element: Element?, at index: Int) {
        guard let element = element else { return }
        
        do {
            try rangeCheckForAdd(at: index)
            if index == 0 {
                first = Node(element: element, next: first)
            } else {
                let prevNode = getNode(at: index - 1)
                let newNode = Node(element: element, next: prevNode?.next)
                prevNode?.next = newNode
            }
            size += 1
        } catch { }
    }
    
    public func addFirst(_ element: Element?) {
        append(element, at: 0)
    }
    
    public func remove(at index: Int) -> Element? {
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
    
    public func removeFirst() -> Element? {
        return remove(at: 0)
    }
    
    public func removeLast() -> Element? {
        return remove(at: size - 1)
    }
    
    public func remove(_ element: Element?) {
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
    
    public func clear() {
        size = 0
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
