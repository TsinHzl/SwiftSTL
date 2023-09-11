//
//  main.swift
//  SwiftSTL
//
//  Created by harllan on 2023/9/9.
//

import Foundation



private func testLinkedList() {
    let linkedList = LinkedList<Int>()
    for i in 0 ... 10 {
        linkedList.append(i + 1)
    }

    linkedList.debugPrint()

    linkedList.remove(5)

    linkedList.debugPrint()
}

private func testDLinkedList() {
    let linkedList = DoubleLinkedList<Int>()
    for i in 0 ... 10 {
        linkedList.append(i + 1)
    }

    linkedList.debugPrint()

    linkedList.remove(7)

    linkedList.debugPrint()
}

testDLinkedList()
