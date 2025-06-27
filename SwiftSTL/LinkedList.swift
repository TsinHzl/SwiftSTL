//
//  LinkedList.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/9.
//  单向链表

import Foundation


public struct LinkedList<E: Equatable>: List {
    
    class Node<E: Equatable> {
        var element: E
        var next: Node?
        
        
        deinit {
            _debugPrint("--- LinkedList.Node.deinit ---")
        }
        
        init(element: E, next: Node?) {
            self.element = element
            self.next = next
        }
    }
    
    private var first: Node<E>?
    
    
    /// 链表的个数
    public private(set) var count: Int = 0
    
    /// 链表是否为空
    public private(set) var isEmpty: Bool = false
    
    
    public init() { }
    
    /// 获取指定index位置的元素
    /// - Parameter index: 索引
    /// - Returns: 没有的话就返回nil
    public func get(at index: Int) -> E? {
        return getNode(at: index)?.element
    }
    
    /// 设置指定index位置的元素
    /// - Parameters:
    ///   - element: 要设置的新元素
    ///   - index: 索引
    /// - Returns: 返回被替换掉的元素，没被替换的话，就返回nil
    public func set(_ element: E, at index: Int) -> E? {
        
        let node = getNode(at: index)
        let oldElement = node?.element
        
        node?.element = element
        
        return oldElement
    }
    
    /// 在指定位置添加元素
    /// - Parameters:
    ///   - element: 要添加的元素
    ///   - index: 索引
    public mutating func append(_ element: E, at index: Int) {
        
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
    /// 移除指定index位置的元素
    /// - Parameter index: 索引
    /// - Returns: 返回移除的元素，没有的话，就返回nil
    public mutating func remove(at index: Int) -> E? {
        do {
            try rangeCheck(at: index)
            
            var oldElement: E?
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
    
    /// 移除指定元素
    /// - Parameter element: 要移除的元素
    public mutating func remove(_ element: E?) {
        if let index = indexOf(element) {
            let _ = remove(at: index)
        }
    }
    
    /// 获取指定元素的索引
    /// - Parameter element: 元素
    /// - Returns: 返回索引index，没有的话就返回nil
    public func indexOf(_ element: E?) -> Int? {
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
    
    /// 清空链表
    public mutating func removeAll() {
        count = 0
        first = nil
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

extension LinkedList {
    private func getNode(at index: Int) -> Node<E>? {
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


// MARK: - for iterator
extension LinkedList: Sequence {
    public func makeIterator() -> LinkedListIterator<E> {
        return LinkedListIterator(linkedList: self)
    }
}

public struct LinkedListIterator<Element: Equatable>: IteratorProtocol {
    private var currentIndex = 0
    private var linkedList: LinkedList<Element>
    
    init(linkedList: LinkedList<Element>) {
        self.linkedList = linkedList
    }
    
    public mutating func next() -> Element? {
        guard currentIndex < linkedList.count else { return nil }
        
        let element = linkedList.get(at: currentIndex)
        currentIndex += 1
        return element
    }
}
