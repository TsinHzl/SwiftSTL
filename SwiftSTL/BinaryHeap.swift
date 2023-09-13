//
//  BinaryHeap.swift
//  SwiftSTLExample
//
//  Created by harllan on 2023/9/12.
//

import Foundation


public struct BinaryHeap<E: Comparable> {
    fileprivate var elements = [E]()
    
    /// 是否是小顶堆，默认不是
    private var isLittle: Bool = false
    
    public var count: Int { elements.count }
    
    
    /// 初始化构造器
    /// - Parameters:
    ///   - isLittle: 是否是小顶堆，默认为false，即为大顶堆
    ///   - elements: 如果这个值不是空的，就会批量建堆，批量建堆时间复杂度为O(logn)
    public init(isLittle: Bool = false, elements: [E] = [E]()) {
        self.isLittle = isLittle
        self.elements = elements
        
        heapifyDown()
    }
    
    /// 清空堆
    public mutating func removeAll() {
        elements.removeAll()
    }
    
    /// 添加元素
    /// - Parameter element: 要添加的元素
    public mutating func append(_ element: E) {
        elements.append(element)
        siftUp(elements.count - 1)
    }
    
    /// 查看堆顶元素
    /// - Returns: 如果堆不为空就返回堆顶元素，否则返回nil
    public func get() -> E? {
        return elements.first
    }
    
    /// 移除堆顶元素
    /// - Returns: 移除的堆顶元素
    public mutating func remove() -> E? {
        if elements.isEmpty { return nil }
        
        let lastIdx = elements.count - 1
        let top = elements.first
        elements[0] = elements[lastIdx]
        elements.removeLast()
        
        siftDown(0)
        return top
    }
    
    /// 替换堆顶元素
    /// - Parameter element: 要替换的元素
    /// - Returns: 被替换之前的堆顶元素
    public mutating func replace(_ element: E) -> E? {
        if elements.isEmpty { return nil }
        
        let top = elements.first
        elements[0] = element
        siftDown(0)
        
        return top
    }
    
    /// 遍历堆元素
    public func traversal() {
        elements.forEach { e in
            _debugPrint(e)
        }
    }
    
    /// 批量建堆
    private mutating func heapifyUp() {
        if elements.count <= 1 { return }
        
        for i in 0 ..< elements.count {
            siftUp(i)
        }
    }
    
    /// 批量建堆 siftDown效率更高
    private mutating func heapifyDown() {
        if elements.count <= 1 { return }
        
        let half = (elements.count >> 1) - 1
        var idx = half
        while idx >= 0 {
            siftDown(idx)
            idx -= 1
        }
    }
    
    
    /// 上滤  时间复杂度O(logn)
    private mutating func siftUp(_ index: Int) {
        let element = elements[index]
        var idx = index
        while idx > 0 {
            // 找到父节点index
            let pidx = (idx - 1) >> 1
            let p = elements[pidx]
            
            if isLittle, element > elements[pidx] { break }
            if !isLittle, element <= elements[pidx] { break }
            
            elements[idx] = p
            idx = pidx
        }
        
        elements[idx] = element
    }
    
    /// 下虑  时间复杂度O(logn)
    private mutating func siftDown(_ index: Int) {
        if index < 0 || index >= elements.count { return }
        
        let element = elements[index]
        var idx = index
        let half = elements.count >> 1
        while idx < half {
            var cidx = (idx << 1) + 1
            var child = elements[cidx]
            let rightIdx = cidx + 1
            if rightIdx < elements.count &&
                ((isLittle && child > elements[rightIdx]) ||
                 (!isLittle && child < elements[rightIdx])) {
                cidx = rightIdx
                child = elements[rightIdx]
            }
            
            if isLittle, child >= element { break }
            if !isLittle, child <= element { break }
            
            elements[idx] = child
            idx = cidx
        }
        
        elements[idx] = element
    }
    
    public func debugPrint() {
        #if DEBUG
        var str = ""
        for e in elements {
            str += "\(e) "
        }
        
        _debugPrint(str)
        #endif
    }
}


// MARK: - for iterator
extension BinaryHeap: Sequence {
    public func makeIterator() -> some IteratorProtocol {
        return BinaryHeapIterator(heap: self)
    }
}

struct BinaryHeapIterator<Element: Comparable>: IteratorProtocol {
    private var currentIndex = 0
    private var heap: BinaryHeap<Element>
    
    init(heap: BinaryHeap<Element>) {
        self.heap = heap
    }
    
    mutating func next() -> Element? {
        guard currentIndex < heap.count else { return nil }
        
        let element = heap.elements[currentIndex]
        currentIndex += 1
        return element
    }
}
