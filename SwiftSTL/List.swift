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


public protocol List {
    
    associatedtype E: Equatable
    
    /// 元素的数量
    var count: Int { get }
    
    /// 是否为空
    var isEmpty: Bool { get }
    
    /// 是否包含某个元素
    func contains(_ element: E?) -> Bool
    
    /// 返回index位置对应的元素
    func get(at index: Int) -> E?
    
    /// 设置index位置元素
    func set(_ element: E, at index: Int) -> E?
    
    /// 添加元素到最后
    mutating func append(_ element: E)
    
    /// 往index位置添加元素
    mutating func append(_ element: E, at index: Int)
    
    /// 删除index位置对应元素
    mutating func remove(at index: Int) -> E?
    
    mutating func remove(_ element: E?)
    
    mutating func removeFirst() -> E?
    
    mutating func removeLast() -> E?
    
    /// 查看元素对应位置
    func indexOf(_ element: E?) -> Int?
    
    /// 清空所有元素
    mutating func removeAll()
}


extension List {
    
    public var isEmpty: Bool { count == 0 }
    
    public func contains(_ element: E?) -> Bool {
        return indexOf(element) != nil
    }
    
    public mutating func append(_ element: E) {
        append(element, at: count)
    }
    
    public mutating func remove(_ element: E?) {
        if let index = indexOf(element) {
            let _ = remove(at: index)
        }
    }
    
    @discardableResult
    public mutating func removeFirst() -> E? {
        return remove(at: 0)
    }
    
    @discardableResult
    public mutating func removeLast() -> E? {
        return remove(at: count - 1)
    }
    
    internal func outOfBounds(at index: Int) throws {
        throw ListError.indexOutOfBounds("index: \(index) out of bounds: \(count)")
    }
    
    internal func rangeCheck(at index: Int) throws {
        if index < 0 || index >= count {
            try outOfBounds(at: index)
        }
    }
    
    internal func rangeCheckForAdd(at index: Int) throws {
        if index < 0 || index > count {
            try outOfBounds(at: index)
        }
    }
    
    internal func ensure(capacity: Int) {}
}

