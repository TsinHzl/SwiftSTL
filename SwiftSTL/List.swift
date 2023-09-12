//
//  List.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/9.
//

import Foundation


internal func _debugPrint(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    print(items, separator: separator, terminator: terminator)
    #endif
}


enum ListError: Error {
    case indexOutOfBounds(String)
}


protocol List {
    
    associatedtype Element: Equatable
    
    /// 元素的数量
    var count: Int { get }
    
    /// 是否为空
    var isEmpty: Bool { get }
    
    /// 是否包含某个元素
    func contains(_ element: Element?) -> Bool
    
    /// 返回index位置对应的元素
    func get(at index: Int) -> Element?
    
    /// 设置index位置元素
    func set(_ element: Element, at index: Int) -> Element?
    
    /// 添加元素到最后
    mutating func append(_ element: Element)
    
    /// 往index位置添加元素
    mutating func append(_ element: Element, at index: Int)
    
    /// 删除index位置对应元素
    mutating func remove(at index: Int) -> Element?
    
    mutating func remove(_ element: Element?)
    
    mutating func removeFirst() -> Element?
    
    mutating func removeLast() -> Element?
    
    /// 查看元素对应位置
    func indexOf(_ element: Element?) -> Int?
    
    /// 清空所有元素
    mutating func removeAll()
    
    
    func outOfBounds(at index: Int) throws
    
    func rangeCheck(at index: Int) throws
    
    func rangeCheckForAdd(at index: Int) throws
    
    func ensure(capacity: Int)
}


extension List {
    
    var isEmpty: Bool { count == 0 }
    
    func contains(_ element: Element?) -> Bool {
        return indexOf(element) != nil
    }
    
    mutating func append(_ element: Element) {
        append(element, at: count)
    }
    
    mutating func remove(_ element: Element?) {
        if let index = indexOf(element) {
            let _ = remove(at: index)
        }
    }
    
    @discardableResult
    mutating func removeFirst() -> Element? {
        return remove(at: 0)
    }
    
    @discardableResult
    mutating func removeLast() -> Element? {
        return remove(at: count - 1)
    }
    
    func outOfBounds(at index: Int) throws {
        throw ListError.indexOutOfBounds("index: \(index) out of bounds: \(count)")
    }
    
    func rangeCheck(at index: Int) throws {
        if index < 0 || index >= count {
            try outOfBounds(at: index)
        }
    }
    
    func rangeCheckForAdd(at index: Int) throws {
        if index < 0 || index > count {
            try outOfBounds(at: index)
        }
    }
    
    func ensure(capacity: Int) {}
}

