//
//  main.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/9.
//

import Foundation



private func testLinkedList() {
    var linkedList = LinkedList<Int>()
    for i in 0 ... 10 {
        linkedList.append(i + 1)
    }

    linkedList.debugPrint()

    linkedList.remove(5)

    linkedList.debugPrint()
}

private func testDLinkedList() {
    var linkedList = DoubleLinkedList<Int>()
    for i in 0 ... 10 {
        linkedList.append(i + 1)
    }

    linkedList.debugPrint()

    linkedList.remove(7)

    linkedList.debugPrint()
}

private func testStack() {
    var stack = Stack<Int>()
    for i in 0 ... 10 {
        stack.push(i + 1)
    }
    stack.debugPrint()
    
    for _ in 0 ... 11 {
        stack.pop()
    }
    
    stack.debugPrint()
}

private func testQueue() {
    var queue = Queue<Int>()
    for i in 0 ... 10 {
        queue.offer(i + 1)
    }
    queue.debugPrint()
    
//    for _ in 0 ... 11 {
//        let _ = queue.poll()
//    }
    
    let _ = queue.poll()
    
    queue.removeAll()
    
    queue.debugPrint()
}

testQueue()
