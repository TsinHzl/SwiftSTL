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
    
    for item in linkedList {
        print(item)
    }
    
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
    
    for item in stack {
        print(item)
    }
    
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
    
    for item in queue {
        print(item)
    }
    
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
    
    for item in queue {
        print(item)
    }
    
    queue.debugPrint()
}

private func testHeap() {
    let maxNum = 10
    var heap = BinaryHeap<Int>()
    for _ in 0 ... maxNum {
        let num = Int.random(in: 1 ... maxNum)
        heap.append(num)
    }
    
    var str = ""
    for _ in 0 ... maxNum {
        let num = heap.remove()
        str += "\(num!) "
    }
    print(str)
    
    var nums = [Int]()
    for _ in 0 ... maxNum {
        let num = Int.random(in: 1 ... maxNum)
        nums.append(num)
    }
    
    var heap1 = BinaryHeap(type: .min ,elements: nums)
    
    str = ""
    for _ in 0 ... maxNum {
        let num = heap1.remove()
        str += "\(num!) "
    }
    print(str)
}

private func testPriorityQueue() {
    let maxNum = 10
    var heap = PriorityQueue<Int>()
    for _ in 0 ... maxNum {
        let num = Int.random(in: 1 ... maxNum)
        heap.append(num)
    }
    
    var str = ""
    for _ in 0 ... maxNum {
        let num = heap.remove()
        str += "\(num!) "
    }
    print(str)
    
    var heap1 = PriorityQueue<Int>(type: .max)
    for _ in 0 ... maxNum {
        let num = Int.random(in: 1 ... maxNum)
        heap1.append(num)
    }
    
    str = ""
    for _ in 0 ... maxNum {
        let num = heap1.remove()
        str += "\(num!) "
    }
    
    heap1.forEach { n in
        print(n)
    }
    print(str)
}


testPriorityQueue()
