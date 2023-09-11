//
//  List.swift
//  SwiftSTL
//
//  Created by MacBook on 2023/9/9.
//

import Foundation


enum ListError: Error {
    case indexOutOfBounds(String)
}


protocol List {
    
    associatedtype Element: Equatable
    
    /// 元素的数量
    var size: Int { get }
    
    /// 是否为空
    var isEmpty: Bool { get }
    
    /// 是否包含某个元素
    func contains(_ element: Element?) -> Bool
    
    /// 返回index位置对应的元素
    func get(at index: Int) -> Element?
    
    /// 设置index位置元素
    func set(_ element: Element?, at index: Int) -> Element?
    
    /// 添加元素到最后
    func add(_ element: Element?)
    
    /// 往index位置添加元素
    func add(_ element: Element?, at index: Int)
    
    /// 删除index位置对应元素
    func remove(at index: Int) -> Element?
    
    func remove(_ element: Element?)
    
    /// 查看元素对应位置
    func indexOf(_ element: Element?) -> Int?
    
    /// 清空所有元素
    func clear()
    
    
    func outOfBounds(at index: Int) throws
    
    func rangeCheck(at index: Int) throws
    
    func rangeCheckForAdd(at index: Int) throws
    
    func ensure(capacity: Int)
}


extension List {
    
    var isEmpty: Bool { size == 0 }
    
    func contains(_ element: Element?) -> Bool {
        return indexOf(element) == nil
    }
    
    func add(_ element: Element?) {
        add(element, at: size)
    }
    
    func remove(_ element: Element?) {
        if let index = indexOf(element) {
            let _ = remove(at: index)
        }
    }
    
    func outOfBounds(at index: Int) throws {
        throw ListError.indexOutOfBounds("index: \(index) out of bounds: \(size)")
    }
    
    func rangeCheck(at index: Int) throws {
        if index < 0 || index >= size {
            try outOfBounds(at: index)
        }
    }
    
    func rangeCheckForAdd(at index: Int) throws {
        if index < 0 || index > size {
            try outOfBounds(at: index)
        }
    }
}

