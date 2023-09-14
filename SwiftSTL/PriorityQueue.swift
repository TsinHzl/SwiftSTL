//
//  PriorityQueue.swift
//  SwiftSTLExample
//
//  Created by harllan on 2023/9/13.
//

import Foundation


struct PriorityQueue<E: Comparable> {
    fileprivate var heap: BinaryHeap<E>
    
    /// 堆元素个数
    public var count: Int { heap.count }
    
    /// 堆是否为空
    public var isEmpty: Bool { heap.isEmpty }
    
    /// 查看堆顶元素
    public var front: E? { heap.front }
    
    /// 初始化构造器
    /// - Parameter type: 大小顶堆类型，默认是小顶堆
    public init(type: BinaryHeap<E>.HeapType = .min) {
        self.heap = BinaryHeap(type: type)
    }
    
    /// 清空堆
    public mutating func removeAll() {
        heap.removeAll()
    }
    
    /// 往队里添加元素
    /// - Parameter element: 要添加的元素
    public mutating func append(_ element: E) {
        heap.append(element)
    }
    
    /// 移除元素
    /// - Returns: 移除的元素，没有的话就返回nil
    public mutating func remove() -> E? {
        return heap.remove()
    }
}


// MARK: - for iterator
extension PriorityQueue: Sequence {
    public func makeIterator() -> some IteratorProtocol {
        return PriorityQueueIterator(heap: self)
    }
}

struct PriorityQueueIterator<Element: Comparable>: IteratorProtocol {
    private var currentIndex = 0
    private var heap: PriorityQueue<Element>
    
    init(heap: PriorityQueue<Element>) {
        self.heap = heap
    }
    
    mutating func next() -> Element? {
        guard currentIndex < heap.count else { return nil }
        
        let element = heap.heap.elements[currentIndex]
        currentIndex += 1
        return element
    }
}
