# SwiftSTL
**SwiftSTL is similar to the C++ STL library**



**[中文版](https://github.com/TsinHzl/SwiftSTL/blob/main/README-zh.md)**



- [Description](#Description)
- [Includes](#Includes)
- [Installation](#Installation)
- [Usage](#Usage)
  - [LinkedList](#LinkedList)
  - [DoubleLinkedList](#DoubleLinkedList)
  - [Stack](#Stack)
  - [Queue](#Queue)
  - [Dequeue](#Dequeue)
  - [BinaryHeap](#BinaryHeap)
  - [PriorityQueue](#PriorityQueue)



#### Description

As known for us, swift only includes a few data structures: Array, Dictionary, Set. but there aren't any other common data structures, **so I just want to make it better for using.  Sometimes, you can code more efficient with more other data structures**

#### Includes

- it includes **some common data structures :**
  - **LinkedList**
  - **DoubleLinkedList**
  - **Stack**
  - **Queue**
  - **Dequeue**
  - **BinaryHeap**
  - **PriorityQueue**

#### Installation

##### cocoapods

- **pod 'SwiftSTL'**
  - or specify a version:  **pod 'SwiftSTL', '~> 1.7'**


##### download framwork

- download the repo.
- and add **SwiftSTL** library to your project

#### Usage

##### Import library

```swift
import SwiftSTL
```



##### Use

###### LinkedList

```swift
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
```



###### DoubleLinkedList

```swift
var dLinkedList = DoubleLinkedList<Int>()
for i in 0 ... 10 {
    dLinkedList.append(i + 1, at: 0)
}

dLinkedList.append(20, at: 5)

dLinkedList.debugPrint()

dLinkedList.remove(at: 5)
dLinkedList.remove(6)
dLinkedList.removeFirst()
dLinkedList.removeLast()

dLinkedList.debugPrint()

for _ in 0 ... 10 {
    dLinkedList.removeFirst()
}

dLinkedList.debugPrint()
```



###### Stack

```swift
var stack = Stack<Int>()
for i in 0 ... 10 {
    stack.push(i + 1)
}
stack.debugPrint()

for _ in 0 ... 11 {
    stack.pop()
}

stack.debugPrint()
```



###### Queue

```swift
var queue = Queue<Int>()
for i in 0 ... 10 {
    queue.offer(i + 1)
}
queue.debugPrint()

let _ = queue.poll()

queue.removeAll()

queue.debugPrint()
```



###### Dequeue

```swift
var deQueue = Dequeue<Int>()
for i in 0 ... 10 {
    deQueue.offerFront(i + 1)
}
for i in 11 ... 20 {
    deQueue.offerRear(i + 1)
}
deQueue.debugPrint()

let _ = deQueue.pollRear()
let _ = deQueue.pollFront()

deQueue.debugPrint()
```



###### BinaryHeap

```swift
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
```



###### PriorityQueue

```swift
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
print(str)
```

