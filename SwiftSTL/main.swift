//
//  main.swift
//  SwiftSTL
//
//  Created by MacBook on 2023/9/9.
//

import Foundation

print("Hello, World!")

let linkedList = LinkedList<Int>()
for i in 0 ... 10 {
    linkedList.add(i + 1)
}

linkedList.debugPrint()

linkedList.remove(at: 0)
