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
    
    for i in 11 ... 20 {
        linkedList.append(i + 1, at: 0)
    }
    
    linkedList.debugPrint()
    
    linkedList.remove(5)
    linkedList.remove(at: 5)
    linkedList.debugPrint()
    
    for _ in 0 ... 30 {
        linkedList.remove(at: 0)
    }
    
    linkedList.debugPrint()
}

private func testDLinkedList() {
    var linkedList = DoubleLinkedList<Int>()
    for i in 0 ... 10 {
        linkedList.append(i + 1, at: 0)
    }
    
    linkedList.append(20, at: 5)
    
    linkedList.debugPrint()

    linkedList.remove(at: 5)
    linkedList.remove(6)
    linkedList.removeFirst()
    linkedList.removeLast()
    
    linkedList.debugPrint()
    
    for _ in 0 ... 10 {
        linkedList.removeFirst()
    }

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

private func testDequeue() {
    var queue = Dequeue<Int>()
    for i in 0 ... 10 {
        queue.offerFront(i + 1)
    }
    for i in 11 ... 20 {
        queue.offerRear(i + 1)
    }
    queue.debugPrint()
    
    let _ = queue.pollRear()
    let _ = queue.pollFront()
    
    queue.debugPrint()
}


testDLinkedList()
